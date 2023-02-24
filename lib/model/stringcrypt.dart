import 'dart:convert';
import 'package:encrypt/encrypt.dart' as xx;

class StringCrypt{
  final xx.Encrypter _encrypter;
  final String _key;
  final xx.IV _iv;

  ///Handles encryption and decryption of strings.
  ///Declare this using StringCrypt("thisisasecretkey", xx.IV.fromLength(16));
  StringCrypt(this._key, this._iv)
      : _encrypter = xx.Encrypter(xx.AES(xx.Key.fromUtf8(_key), mode: xx.AESMode.cbc));

  String encrypt(String text) {
    if (text == '') return '';
    final encrypted = _encrypter.encrypt(text, iv: _iv);
    return base64.encode(encrypted.bytes);
  }

  String decrypt(String text) {
    if (text == '') return '';
    final decrypted =
    _encrypter.decrypt(xx.Encrypted.from64(text), iv: _iv);
    return decrypted;
  }
}