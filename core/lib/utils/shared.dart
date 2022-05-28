import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
class Shared {
  static Future<HttpClient> customHttpClient() async {
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    try {
      List<int> bytes = [];
      bytes = (await rootBundle.load('certificates/certificates.cer'))
          .buffer
          .asUint8List();
      securityContext.setTrustedCertificatesBytes(bytes);
      debugPrint('createHttpClient() - cert added!');
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        debugPrint('createHttpClient() - cert already trusted! Skipping.');
      } else {
        log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('unexpected error $e');
      rethrow;
    }
    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback = (X509Certificate cert,String host,int port) => false;
    return httpClient;
  }

  static Future<http.Client> createLEClient() async{
    IOClient client = IOClient(await Shared.customHttpClient());
    return client;
  }
}