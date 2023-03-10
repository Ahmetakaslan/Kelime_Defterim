import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sozluk_uygulamasi/kelimelerdao.dart';
import 'package:sozluk_uygulamasi/main.dart';

class KelimeKayit extends StatefulWidget {
  const KelimeKayit({super.key});

  @override
  State<KelimeKayit> createState() => _KelimeKayitState();
}

class _KelimeKayitState extends State<KelimeKayit> {
  Future<void> kelimeKaydet(
      String kelime_ingilizce, String kelime_turkce) async {
    Kelimelerdao().kelimeEkle(kelime_ingilizce, kelime_turkce);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Ana_Ekran()));
  }

  TextEditingController tf_ingilizce = TextEditingController();
  TextEditingController tf_turkce = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAAB7B8),
        title: Text("Kelime Kaydet"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: size.width * .75,
                child: Card(
                    color: Color(0xFFF2F3F4),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2),
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(20))),
                    child: SizedBox(
                        width: size.width * 0.40,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                          child: TextField(
                            controller: tf_ingilizce,
                            decoration: InputDecoration(hintText: "Ingilizce"),
                          ),
                        ))),
              ),
              SizedBox(
                width: size.width * .75,
                child: Card(
                  color: Color(0xFFF2F3F4),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20))),
                  child: SizedBox(
                    width: size.width * 0.40,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: TextField(
                        controller: tf_turkce,
                        decoration: InputDecoration(hintText: "Türkçe"),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (tf_ingilizce.text != "" && tf_turkce != "") {
                      kelimeKaydet(tf_ingilizce.text, tf_turkce.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                elevation: 0,
                duration: Duration(seconds: 2),
                backgroundColor: Colors.transparent,
                content: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text("Lütfen Alanları Doldurun")),
                  
                    ),
                  ),
                  
                ),
              ));
                    }
                  },
                  child: Text("Kaydet"))
            ],
          ),
        ),
      ),
    );
  }
}
   
