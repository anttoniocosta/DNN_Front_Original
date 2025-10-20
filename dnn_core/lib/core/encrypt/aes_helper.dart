import 'dart:convert';
import 'dart:typed_data';
import 'package:dnn_core/all_exports.dart';
import 'package:pointycastle/export.dart';

class AesHelper {
  static String encrypt(String plainText) {
    Uint8List keyBytes =
        Uint8List.fromList(utf8.encode(dnnController.dnnConfigs!.key!));
    Uint8List plaintext = Uint8List.fromList(utf8.encode(plainText));

    KeyParameter keyParam = KeyParameter(keyBytes);
    PaddedBlockCipherParameters params =
        PaddedBlockCipherParameters(keyParam, null);

    PaddedBlockCipher cipher =
        PaddedBlockCipherImpl(PKCS7Padding(), BlockCipher('AES/ECB'));
    cipher.init(true, params);

    Uint8List encrypted = cipher.process(plaintext);

    return base64.encode(encrypted);
  }

  static String decrypt(String cipherText) {
    Uint8List keyBytes =
        Uint8List.fromList(utf8.encode(dnnController.dnnConfigs!.key!));
    Uint8List cipherTextBytes = Uint8List.fromList(base64.decode(cipherText));

    KeyParameter keyParam = KeyParameter(keyBytes);
    PaddedBlockCipherParameters params =
        PaddedBlockCipherParameters(keyParam, null);

    PaddedBlockCipher cipher =
        PaddedBlockCipherImpl(PKCS7Padding(), BlockCipher('AES/ECB'));
    cipher.init(false, params);

    Uint8List decrypted = cipher.process(cipherTextBytes);

    return utf8.decode(decrypted);
  }
}
