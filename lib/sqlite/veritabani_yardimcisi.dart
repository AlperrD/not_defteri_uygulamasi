import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi{
  static const String veritabaniAdi = "not_defteri.sqlite";

  static Future<Database> veritabaniErisim() async {
    String veritabaniYolu =  join(await getDatabasesPath(),veritabaniAdi);

    if(await databaseExists(veritabaniYolu)){
      print("Veri tabanı zaten var. Kopyalamaya gerek yok.");
    }else{
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");
    List<int> bytes = await data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
    await File(veritabaniYolu).writeAsBytes(bytes, flush: true);
    print("veritabani kopyalandı");
    }
    return openDatabase(veritabaniYolu);
  }
}