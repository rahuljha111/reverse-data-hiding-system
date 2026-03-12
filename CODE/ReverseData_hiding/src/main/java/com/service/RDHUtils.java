package com.service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.BitSet;
import java.util.Random;

import javax.imageio.ImageIO;

public class RDHUtils {
	
	
	
	public static BufferedImage permuteImage(BufferedImage img, long seed) {
        int w = img.getWidth(), h = img.getHeight();
        BufferedImage out = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);

        int n = w * h;
        int[] idx = new int[n];
        for (int i = 0; i < n; ++i) idx[i] = i;

        Random rnd = new Random(seed);
        for (int i = n - 1; i > 0; --i) {
            int j = rnd.nextInt(i + 1);
            int tmp = idx[i]; idx[i] = idx[j]; idx[j] = tmp;
        }

        int k = 0;
        for (int y = 0; y < h; ++y) {
            for (int x = 0; x < w; ++x) {
                int srcIndex = idx[k++];
                int sx = srcIndex % w;
                int sy = srcIndex / w;
                out.setRGB(x, y, img.getRGB(sx, sy));
            }
        }
        return out;
    }

    public static BufferedImage inversePermuteImage(BufferedImage permuted, long seed) {
        int w = permuted.getWidth(), h = permuted.getHeight();
        BufferedImage out = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);

        int n = w * h;
        int[] idx = new int[n];
        for (int i = 0; i < n; ++i) idx[i] = i;

        Random rnd = new Random(seed);
        for (int i = n - 1; i > 0; --i) {
            int j = rnd.nextInt(i + 1);
            int tmp = idx[i]; idx[i] = idx[j]; idx[j] = tmp;
        }

        int k = 0;
        for (int y = 0; y < h; ++y) {
            for (int x = 0; x < w; ++x) {
                int origIndex = idx[k++];
                int ox = origIndex % w;
                int oy = origIndex / w;
                out.setRGB(ox, oy, permuted.getRGB(x, y));
            }
        }
        return out;
    }

    // --- Bit helpers ---
    private static byte[] bitsToBytes(BitSet bits, int bitLen) {
        int bytes = (bitLen + 7) / 8;
        byte[] arr = new byte[bytes];
        for (int i = 0; i < bitLen; ++i) {
            if (bits.get(i)) {
                arr[i / 8] |= (1 << (7 - (i % 8)));
            }
        }
        return arr;
    }

    private static BitSet bytesToBits(byte[] bytes, int bitLen) {
        BitSet bs = new BitSet(bitLen);
        for (int i = 0; i < bitLen; ++i) {
            int b = bytes[i / 8] & 0xFF;
            int bit = (b >> (7 - (i % 8))) & 1;
            if (bit == 1) bs.set(i);
        }
        return bs;
    }

    // --- Reversible LSB embed/extract ---
    public static class EmbedResult {
        public BufferedImage stego;
        public byte[] metadataBytes;
    }

    public static EmbedResult embedReversibleLSB(BufferedImage baseImage, String message) throws IOException {
        int w = baseImage.getWidth(), h = baseImage.getHeight();
        int capacity = w * h; // 1 bit per pixel (blue channel)

        byte[] msgBytes = message.getBytes("UTF-8");
        BitSet msgBits = bytesToBits(msgBytes, msgBytes.length * 8);
        int msgBitLen = msgBytes.length * 8;

        int origLSBCount = msgBitLen;
        byte[] header = new byte[8];
        header[0] = (byte) ((msgBitLen >> 24) & 0xFF);
        header[1] = (byte) ((msgBitLen >> 16) & 0xFF);
        header[2] = (byte) ((msgBitLen >> 8) & 0xFF);
        header[3] = (byte) ((msgBitLen) & 0xFF);
        header[4] = (byte) ((origLSBCount >> 24) & 0xFF);
        header[5] = (byte) ((origLSBCount >> 16) & 0xFF);
        header[6] = (byte) ((origLSBCount >> 8) & 0xFF);
        header[7] = (byte) ((origLSBCount) & 0xFF);

        BitSet origLSBBits = new BitSet(origLSBCount);
        int bitIndex = 0;
        outer:
        for (int y = 0; y < h; ++y) {
            for (int x = 0; x < w; ++x) {
                if (bitIndex >= origLSBCount) break outer;
                int rgb = baseImage.getRGB(x, y);
                int blue = rgb & 0xFF;
                int lsb = blue & 1;
                if (lsb == 1) origLSBBits.set(bitIndex);
                bitIndex++;
            }
        }

        BitSet totalBits = new BitSet(header.length*8 + origLSBCount + msgBitLen);
        int totalLen = 0;
        BitSet headerBits = bytesToBits(header, header.length * 8);
        for (int i = 0; i < header.length * 8; ++i) {
            if (headerBits.get(i)) totalBits.set(totalLen);
            totalLen++;
        }
        for (int i = 0; i < origLSBCount; ++i) {
            if (origLSBBits.get(i)) totalBits.set(totalLen);
            totalLen++;
        }
        for (int i = 0; i < msgBitLen; ++i) {
            if (msgBits.get(i)) totalBits.set(totalLen);
            totalLen++;
        }

        if (totalLen > capacity) {
            throw new IOException("Not enough capacity. Required bits: " + totalLen + " capacity: " + capacity);
        }

        BufferedImage stego = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
        int tIndex = 0;
        for (int y = 0; y < h; ++y) {
            for (int x = 0; x < w; ++x) {
                int rgb = baseImage.getRGB(x, y);
                int a = (rgb >> 24) & 0xFF;
                int r = (rgb >> 16) & 0xFF;
                int g = (rgb >> 8) & 0xFF;
                int b = rgb & 0xFF;
                int bit = 0;
                if (tIndex < totalLen && totalBits.get(tIndex)) bit = 1;
                tIndex++;
                int newB = (b & 0xFE) | bit;
                int newRgb = (a << 24) | (r << 16) | (g << 8) | newB;
                stego.setRGB(x, y, newRgb);
            }
        }

        EmbedResult res = new EmbedResult();
        res.stego = stego;
        res.metadataBytes = header;
        return res;
    }

    public static class ExtractResult {
        public String message;
        public BufferedImage recoveredImage;
    }

    public static ExtractResult extractReversibleLSB(BufferedImage stego) throws IOException {
        int w = stego.getWidth(), h = stego.getHeight();
        int capacity = w * h;

        BitSet headerBits = new BitSet(64);
        int bitRead = 0;
        outerHeader:
        for (int y = 0; y < h; ++y) {
            for (int x = 0; x < w; ++x) {
                int rgb = stego.getRGB(x, y);
                int b = rgb & 0xFF;
                int lsb = b & 1;
                if (lsb == 1) headerBits.set(bitRead);
                bitRead++;
                if (bitRead >= 64) break outerHeader;
            }
        }
        byte[] headerBytes = bitsToBytes(headerBits, 64);
        int msgBitLen = ((headerBytes[0] & 0xFF) << 24) | ((headerBytes[1] & 0xFF) << 16) | ((headerBytes[2] & 0xFF) << 8) | (headerBytes[3] & 0xFF);
        int origLSBCount = ((headerBytes[4] & 0xFF) << 24) | ((headerBytes[5] & 0xFF) << 16) | ((headerBytes[6] & 0xFF) << 8) | (headerBytes[7] & 0xFF);

        int totalLen = 64 + origLSBCount + msgBitLen;
        if (totalLen > capacity) {
            throw new IOException("Stego appears corrupted or header indicates too-large payload.");
        }

        BitSet storedBits = new BitSet(totalLen);
        int tIdx = 0;
        outerAll:
        for (int y = 0; y < h; ++y) {
            for (int x = 0; x < w; ++x) {
                int rgb = stego.getRGB(x, y);
                int b = rgb & 0xFF;
                int lsb = b & 1;
                if (lsb == 1) storedBits.set(tIdx);
                tIdx++;
                if (tIdx >= totalLen) break outerAll;
            }
        }

        int cursor = 64;
        BitSet origLSBs = new BitSet(origLSBCount);
        for (int i = 0; i < origLSBCount; ++i) {
            if (storedBits.get(cursor++)) origLSBs.set(i);
        }
        BitSet msgBits = new BitSet(msgBitLen);
        for (int i = 0; i < msgBitLen; ++i) {
            if (storedBits.get(cursor++)) msgBits.set(i);
        }

        BufferedImage recovered = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
        int pos = 0;
        outerRestore:
        for (int y = 0; y < h; ++y) {
            for (int x = 0; x < w; ++x) {
                int rgb = stego.getRGB(x, y);
                int a = (rgb >> 24) & 0xFF;
                int r = (rgb >> 16) & 0xFF;
                int g = (rgb >> 8) & 0xFF;
                int b = rgb & 0xFF;
                if (pos < origLSBCount) {
                    int origBit = origLSBs.get(pos) ? 1 : 0;
                    b = (b & 0xFE) | origBit;
                }
                int newRgb = (a << 24) | (r << 16) | (g << 8) | (b & 0xFF);
                recovered.setRGB(x, y, newRgb);
                pos++;
            }
        }

        byte[] msgBytes = bitsToBytes(msgBits, msgBitLen);
        String message = new String(msgBytes, "UTF-8");

        ExtractResult er = new ExtractResult();
        er.message = message;
        er.recoveredImage = recovered;
        return er;
    }

    // Utilities
    public static byte[] bufferedImageToBytesPNG(BufferedImage img) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(img, "png", baos);
        return baos.toByteArray();
    }

    public static BufferedImage readImage(InputStream in) throws IOException {
        return ImageIO.read(in);
    }

    public static String generateSeedHex() {
        SecureRandom sr = new SecureRandom();
        long seed = sr.nextLong();
        return Long.toHexString(seed);
    }

	/*
	 * public static long seedFromHex(String hex) { return Long.parseLong(hex, 16);
	 * }
	 */

    public static String encodeMasterKey(String seedHex) {
        String s = "seed:" + seedHex;
        return Base64.getEncoder().encodeToString(s.getBytes());
    }

    public static String decodeMasterKey(String keyBase64) {
        byte[] b = Base64.getDecoder().decode(keyBase64);
        return new String(b);
    }
    
    public static BufferedImage encryptImage(BufferedImage original, String hexKey) {
        int width = original.getWidth();
        int height = original.getHeight();

        BufferedImage encrypted = new BufferedImage(width, height, original.getType());

        long seed = seedFromHex(hexKey); // fixed parsing
        Random rand = new Random(seed);

        // Create mapping of pixel positions
        int totalPixels = width * height;
        int[] positions = new int[totalPixels];
        for (int i = 0; i < totalPixels; i++) positions[i] = i;

        // Shuffle pixel order using key-based randomness
        for (int i = totalPixels - 1; i > 0; i--) {
            int j = rand.nextInt(i + 1);
            int tmp = positions[i];
            positions[i] = positions[j];
            positions[j] = tmp;
        }

        // Apply permutation
        for (int i = 0; i < totalPixels; i++) {
            int srcX = i % width;
            int srcY = i / width;
            int dstIndex = positions[i];
            int dstX = dstIndex % width;
            int dstY = dstIndex / width;

            int pixel = original.getRGB(srcX, srcY);
            encrypted.setRGB(dstX, dstY, pixel);
        }

        return encrypted;
    }

    // ✅ Decrypt back using the same key (reverses permutation)
    public static BufferedImage decryptImage(BufferedImage encrypted, String hexKey) {
        int width = encrypted.getWidth();
        int height = encrypted.getHeight();

        BufferedImage decrypted = new BufferedImage(width, height, encrypted.getType());

        long seed = seedFromHex(hexKey);
        Random rand = new Random(seed);

        int totalPixels = width * height;
        int[] positions = new int[totalPixels];
        for (int i = 0; i < totalPixels; i++) positions[i] = i;

        for (int i = totalPixels - 1; i > 0; i--) {
            int j = rand.nextInt(i + 1);
            int tmp = positions[i];
            positions[i] = positions[j];
            positions[j] = tmp;
        }

        // Reverse permutation
        for (int i = 0; i < totalPixels; i++) {
            int srcIndex = positions[i];
            int srcX = srcIndex % width;
            int srcY = srcIndex / width;
            int dstX = i % width;
            int dstY = i / width;

            int pixel = encrypted.getRGB(srcX, srcY);
            decrypted.setRGB(dstX, dstY, pixel);
        }

        return decrypted;
    }

    // ✅ FIXED: Convert hex key → long seed safely
    public static long seedFromHex(String hex) {
        try {
            return Long.parseLong(hex, 16);
        } catch (NumberFormatException e) {
            // fallback for shorter keys
            return hex.hashCode();
        }
    }

}
