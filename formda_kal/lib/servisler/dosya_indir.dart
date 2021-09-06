import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Indir {
  static Future<String> dosyaIndir(String url, String dosyaAdi) async {
    final dir = await getApplicationDocumentsDirectory();
    final dosyaYolu = '${dir.path}/$dosyaAdi';
    final response = await http.get(Uri.parse(url));
    final dosya = File(dosyaYolu);

    await dosya.writeAsBytes(response.bodyBytes);
    return dosyaYolu;
  }
}
