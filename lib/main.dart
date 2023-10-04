
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi/viewmodel/VeriTabanYardimcisi.dart';

import 'package:sozluk_uygulamasi/model/kelimelerDb.dart';
import 'package:sozluk_uygulamasi/viewmodel/kelimelerdao.dart';

import 'view/detaysayfa.dart';
import 'view/kelimekaydet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sözlük Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Ana_Ekran(),
    );
  }
}

class Ana_Ekran extends StatefulWidget {
 

  @override
  State<Ana_Ekran> createState() => _Ana_EkranState();
}

class _Ana_EkranState extends State<Ana_Ekran> {
  bool aramaYapiliyormu = false;
  String aranacakKelime = "";

  Future<List<Kelimeler>> kelimeleriGoster() async {
    var tumkelimeler = await Kelimelerdao().tumKelimaler();
    return tumkelimeler;
  }

  Future<List<Kelimeler>> aramayap(String kelimeara) async {
    var aranankelime = await Kelimelerdao().kelimeAra(kelimeara);
    return aranankelime;
  }

  TextEditingController controller = TextEditingController();
Future<bool>uygulamaiKapat ()async{
  return exit(1);
}
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: aramaYapiliyormu
            ? AppBar(
              leading: IconButton(icon: Icon(Icons.arrow_back,),onPressed: () { uygulamaiKapat();}),
                backgroundColor: Color(0xFF2C3E50 ),
                actions: [
                  aramaYapiliyormu
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              aramaYapiliyormu = false;
                              aranacakKelime = "";
                              controller.clear();
                            });
                          },
                          icon: Icon(Icons.cancel))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              aramaYapiliyormu = true;
                            });
                          },
                          icon: Icon(Icons.search))
                ],
                title: aramaYapiliyormu
                    ? TextField(
                      style: TextStyle(color: Colors.red),
                        controller: controller,
                        decoration: InputDecoration(
                          // Yazı Yazarken  ki gösterilen renk
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.5),
                          ),
                          // Yazı Yazmadan önce ki gösterilen renk
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.5),
                          ),
                          hintText: "Aranacak Kelime ",
                        ),
                        onChanged: (aramaSonucu) {
                          print("Arama Sonucu :${aramaSonucu} ");
                          setState(() {
                            aranacakKelime = aramaSonucu;
                          });
                        })
                    : Text("Sözlük"),
              )
            : AppBar(
              backgroundColor: Color(0xFF909497
),
                actions: [
                  aramaYapiliyormu
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              aramaYapiliyormu = false;
                              aranacakKelime = "";
                            });
                          },
                          icon: Icon(Icons.cancel))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              aramaYapiliyormu = true;
                            });
                          },
                          icon: Icon(Icons.search))
                ],
                title: aramaYapiliyormu
                    ? TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.5),
                          ),
                          hintText: "Aranacak Kelime ",
                        ),
                        onChanged: (aramaSonucu) {
                          setState(() {
                            print("Arama Sonucu :${aramaSonucu} ");
                            aranacakKelime = aramaSonucu;
                          });
                        })
                    : Text("Sözlük"),
              ),
        body: FutureBuilder<List<Kelimeler>>(
          future:
              aramaYapiliyormu ? aramayap(aranacakKelime) : kelimeleriGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kelimeListesi = snapshot.data;
              return GridView.builder(itemCount: kelimeListesi!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 1),
                itemBuilder: (context, index) {
                  var kelimem = kelimeListesi![index];
                  return GestureDetector(
                    onTap: ()=> Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetaySayfa(kelimem))),
                    child: Card(
                      shape: Border.all(width: 2),
                      child: Center(
                        child: Text(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            kelimem.ingilizce),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Veri Yok"),
              );
            }
          },
        ),
          floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => KelimeKayit(),));
        },
      
       backgroundColor: Colors.grey[400],
        child: const Icon(Icons.save),
      ),);
  }
}
/*

ListView.builder(
                itemCount: kelimeListesi!.length,
                itemBuilder: (context, index) {
                  ///değişti
                  var kelimem = kelimeListesi[index];

                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetaySayfa(kelimem)),
                    ),
                    child: SizedBox(
                      height: 55,
                      child: Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              
                              Text(
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  kelimem.ingilizce),
                              Text(
                                kelimem.turkce,
                              ),
                            ]),
                      ),
                    ),
                  );
                },
              );



*/
