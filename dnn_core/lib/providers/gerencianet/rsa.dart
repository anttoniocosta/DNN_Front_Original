import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';
import 'package:pointycastle/asymmetric/rsa.dart';
import 'package:pointycastle/pointycastle.dart';

class RSACustom {
  static String encrypt(String data, String mKey) {
    dynamic publicKey = RSAKeyParser().parse(mKey);

    // final parser = RSAKeyParser();
    //RSAPublicKey publicKey = parser.parse(mKey);
    RSAEngine e = RSAEngine();
    PKCS1Encoding enc = PKCS1Encoding(e);
    enc.init(true, PublicKeyParameter<RSAPublicKey>(publicKey));
    return base64.encode(enc.process(Uint8List.fromList(data.codeUnits)));
  }
}
