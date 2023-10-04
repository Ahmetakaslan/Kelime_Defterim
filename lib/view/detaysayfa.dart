import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sozluk_uygulamasi/view/guncelle.dart';
import 'package:sozluk_uygulamasi/model/kelimelerDb.dart';
import 'package:sozluk_uygulamasi/model/kelimelerdao.dart';
import 'package:sozluk_uygulamasi/main.dart';

class DetaySayfa extends StatefulWidget {
  Kelimeler kelime;
  DetaySayfa(this.kelime);

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  Future<void> kelimeSil(int kelime_id) async {
    Kelimelerdao().kelimeSil(kelime_id);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Ana_Ekran(),
    ));
  }



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                kelimeSil(widget.kelime.kelime_id);
              },
              child: Text(
                "Sil",
                style: TextStyle(fontSize: 20, color: Colors.black),
              )),
          TextButton(
              onPressed: () {
         Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Guncelle(widget.kelime),
    ));
              },
              child: Text("Güncelle",  style: TextStyle(fontSize: 20, color: Colors.black),))
        ],
        backgroundColor: Color(0xFFB3B6B7),
      ),
      body: Center(
        child: Column(
   
         
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Text(widget.kelime.ingilizce,
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.pink,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(widget.kelime.turkce,
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
