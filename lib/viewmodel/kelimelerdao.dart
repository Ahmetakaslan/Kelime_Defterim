import 'dart:collection';

import 'package:sozluk_uygulamasi/viewmodel/VeriTabanYardimcisi.dart';
import 'package:sozluk_uygulamasi/model/kelimelerDb.dart';

class Kelimelerdao {



  // get all data
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





  // search data
   Future<List<Kelimeler>> kelimeAra(String kelimeAra) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("Select * from kelimeler  WHERE ingilizce like '%$kelimeAra%'");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kelimeler(satir["kelime_id"], satir["ingilizce"], satir["turkce"]);
    });
  }




  // delete data
   Future<void> kelimeSil(int kelime_id) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    db.delete("kelimeler",where: "kelime_id=?",whereArgs: [kelime_id]);
  }





  // add data
   Future<void> kelimeEkle(String kelime_ingilizce,String kelime_turkce) async {
    var db = await VeriTabaniYardimcisi.connectToDatabase();
    var a=Map<String,dynamic>();
   
    a["ingilizce"]=kelime_ingilizce;
    a["turkce"]=kelime_turkce;
    db.insert("kelimeler",a );
 
  }


  

  // update data
   Future<void> kelimeGuncelle (int kelime_id,String kelime_ingilizce,String kelime_turkce)async{
   var db = await VeriTabaniYardimcisi.connectToDatabase();
   var a=Map<String,dynamic>();
   a["ingilizce"]=kelime_ingilizce;
   a["turkce"]=kelime_turkce;
   db.update("kelimeler", a ,where: "kelime_id=?",whereArgs: [kelime_id]);
   
  }
}
