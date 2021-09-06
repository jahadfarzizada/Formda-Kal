import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formda_kal/sayfalar/govde.dart';

class Vki_Hesapla extends StatefulWidget {
  bool sayfa_kontrol;
  String Email, AdSoyad;
  Vki_Hesapla(
      {Key? key,
      required this.sayfa_kontrol,
      required this.Email,
      required this.AdSoyad})
      : super(key: key);

  @override
  _Vki_HesaplaState createState() => _Vki_HesaplaState();
}

class _Vki_HesaplaState extends State<Vki_Hesapla> {
  late var _kilo, _boy, _cinsiyet = 'Erkek';
  late double _vki;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          'VKİ Hesaplayıcı',
                          style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 30,
                            color: Color.fromRGBO(56, 36, 105, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlutterToggleTab(
                          width: 100,
                          height: 100,
                          borderRadius: 25,
                          initialIndex: 0,
                          isShadowEnable: true,
                          selectedBackgroundColors: [
                            Color.fromRGBO(56, 36, 105, 0.9)
                          ],
                          unSelectedBackgroundColors: [
                            Color.fromRGBO(248, 248, 246, 1)
                          ],
                          selectedTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          unSelectedTextStyle: TextStyle(
                              color: Color.fromRGBO(187, 172, 255, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          labels: ["Erkek", "Kadın"],
                          icons: [
                            FontAwesomeIcons.male,
                            FontAwesomeIcons.female
                          ],
                          selectedLabelIndex: (index) {
                            if (index == 0) {
                              setState(() {
                                _cinsiyet = 'Erkek';
                              });
                            } else {
                              setState(() {
                                _cinsiyet = 'Kadın';
                              });
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(255, 250, 236, 0.5),
                          ),
                          width: 450,
                          height: 250,
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 80),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              hintText: 'Boyunuzu giriniz (sm cinsinden)',
                              hintStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                              ),
                            ),
                            onChanged: (x) {
                              setState(() {
                                _boy = int.parse(x);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(251, 233, 227, 0.3),
                          ),
                          width: 450,
                          height: 250,
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 80),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              hintText: 'Kilonuzu giriniz (kg cinsinden)',
                              hintStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                              ),
                            ),
                            onChanged: (x) {
                              setState(() {
                                _kilo = int.parse(x);
                              });
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          width: 450,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            onPressed: _VKIHesapla,
                            padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color.fromRGBO(241, 238, 255, 0.9),
                            child: Text(
                              'VKİ Hesapla',
                              style: TextStyle(
                                color: Color.fromRGBO(56, 36, 105, 1),
                                letterSpacing: 1.5,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _VKIHesapla() {
    _vki = _kilo / ((_boy / 100) * (_boy / 100));
    if (widget.sayfa_kontrol == false) {
      //false ise yeni kullanıcı oluştur
      FirebaseFirestore
          .instance //hesap oluşturduktan sonra, kullanıcıyı veritabanına ekle
          .collection("Kullanicilar")
          .doc(widget.Email)
          .set(
        {
          "Ad Soyad": widget.AdSoyad,
          "Email": widget.Email,
          "Cinsiyet": _cinsiyet,
          "Boy": _boy,
          "Kilo": _kilo,
          "VKI": _vki,
          "Hedef": '2500',
        },
      ).whenComplete(
        //bu işlemler tamamlandıktan sonra Oturum Aç
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Govde()),
            (Route<dynamic> route) => false),
      );
    } else {
      //true ise değerleri güncelle
      FirebaseFirestore.instance
          .collection('Kullanicilar')
          .doc(widget.Email)
          .update(
        //kullanıcı bilgilerini göncelle
        {'Boy': _boy, 'Kilo': _kilo, 'VKI': _vki},
      ).whenComplete(() => Navigator.pop(context)); //bittiğinde geri dön
    }
  }
}
