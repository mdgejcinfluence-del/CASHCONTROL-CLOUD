import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SecurityService {
  // Hachage du PIN en SHA-256
  static String hashPIN(String pin) {
    var bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  // Chiffrement AES-256 d'un rapport JSON
  static String encryptReport(String jsonString, String pin) {
    final key = encrypt.Key.fromUtf8(hashPIN(pin).substring(0, 32)); // Clé 32 bytes
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(jsonString, iv: iv);
    return encrypted.base64;
  }

  // Déchiffrement AES-256
  static String decryptReport(String encryptedBase64, String pin) {
    try {
      final key = encrypt.Key.fromUtf8(hashPIN(pin).substring(0, 32));
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));

      return encrypter.decrypt64(encryptedBase64, iv: iv);
    } catch (e) {
      return "ERREUR_PIN_INCORRECT";
    }
  }
}