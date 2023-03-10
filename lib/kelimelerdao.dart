import 'dart:collection';

import 'package:sozluk_uygulamasi/VeriTabanYardimcisi.dart';
import 'package:sozluk_uygulamasi/kelimelerDb.dart';

class Kelimelerdao {
  Future<List<Kelimeler>> tumKelimaler() async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("Select * from kelimeler");
        print(maps.length.toString());
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      print(satir["ingilizce"]);
      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }
   Future<List<Kelimeler>> kelimeAra(String kelimeAra) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("Select * from kelimeler  WHERE ingilizce like '%$kelimeAra%'");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }
   Future<void> kelimeSil(int kelime_id) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    db.delete("kelimeler",where: "kelime_id=?",whereArgs: [kelime_id]);
  }
   Future<void> kelimeEkle(String kelime_ingilizce,String kelime_turkce) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    var a=Map<String,dynamic>();
   
    a["ingilizce"]=kelime_ingilizce;
    a["turkce"]=kelime_turkce;
    db.insert("kelimeler",a );
 
  }
   Future<void> kelimeGuncelle (int kelime_id,String kelime_ingilizce,String kelime_turkce)async{
   var db = await VeriTabaniYardimcisi.connectToDatabase();
   var a=Map<String,dynamic>();
   a["ingilizce"]=kelime_ingilizce;
   a["turkce"]=kelime_turkce;
   db.update("kelimeler", a ,where: "kelime_id=?",whereArgs: [kelime_id]);
   
  }
}
