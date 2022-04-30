import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
String encrypt(String plainText) {
  final key = Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);
 
  final encrypter = Encrypter(AES(key));
 
  final encrypted = encrypter.encrypt(plainText, iv: iv);
 
  return encrypted.base64;
}