import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionManager {
  // AES encryption key
  static final String _encryptionKey = 'your-secret-key-that-is-32-characters';  // 32-byte key for AES-256

  static String encryptData(String data) {
    final keyBytes = encrypt.Key.fromUtf8(_encryptionKey.padRight(32, ' ')); // AES-256 requires 32 bytes key
    final iv = encrypt.IV.fromLength(16); // 16-byte Initialization Vector (IV)

    final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes, mode: encrypt.AESMode.cbc));

    final encrypted = encrypter.encrypt(data, iv: iv);

    return encrypted.base64; // Return the encrypted data as base64
  }

  static String decryptData(String encryptedData) {
    final keyBytes = encrypt.Key.fromUtf8(_encryptionKey.padRight(32, ' '));
    final iv = encrypt.IV.fromLength(16); //
    final encrypter = encrypt.Encrypter(encrypt.AES(keyBytes, mode: encrypt.AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    return decrypted;
  }
}
