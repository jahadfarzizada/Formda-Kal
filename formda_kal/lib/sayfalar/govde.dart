import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formda_kal/sayfalar/ayarlar.dart';
import 'package:formda_kal/sayfalar/grup.dart';
import 'package:formda_kal/sayfalar/grup_istek.dart';
import 'package:formda_kal/sayfalar/su_i%C3%A7.dart';
import 'package:formda_kal/sayfalar/tuketim_raporu.dart';
import 'package:intl/intl.dart';

import 'VKI_goruntule.dart';

class Govde extends StatefulWidget {
  const Govde({Key? key}) : super(key: key);

  @override
  _GovdeState createState() => _GovdeState();
}

class _GovdeState extends State<Govde> {
  String? _myemail =
      FirebaseAuth.instance.currentUser!.email; //şuanki kullanıcının emaili
  //Veritabanı tarih referansı
  CollectionReference tarihRef =
      FirebaseFirestore.instance.collection('Tarihler');
  int _selectedIndex = 0;
  late Widget _body;
  double _value = 0;
  var _tuketilen_su = 0;
  late String _ay, _gun;
  int _hedef = 2500;

  void initState() {
    super.initState();
    hedefAl();
    suKontrol();
    tarihKontrol();
    _body = SuIc(
      value: _value,
      tuketilen_su: _tuketilen_su,
      ay: _ay,
      gun: _gun,
      tarihRef: tarihRef,
    ); //Uygulama başlarken Ana Sayfa gösterilir
  }

  //bugünün tarih bilgileri
  tarihKontrol() async {
    final now = new DateTime.now();
    setState(() {
      _ay = new DateFormat.MMM().format(now);
      _gun = new DateFormat.d().format(now);
    });
  }

  suKontrol() async {
    tarihRef.doc(_ay).collection(_myemail!).doc(_gun).snapshots().listen(
      (doc) {
        _value = (doc.get('Tüketilen') / _hedef);
        _tuketilen_su = doc.get('Tüketilen');
      },
    );
  }

  hedefAl() async {
    FirebaseFirestore.instance
        .collection('Kullanicilar')
        .doc(_myemail)
        .snapshots()
        .listen((doc) {
      setState(() => _hedef = doc["Hedef"]);
    });
  }

//Navigation Bar sayfa geçişleri
  void onTabChange(int index) {
    _selectedIndex = index;
    if (index == 0) {
      _gitSuIc();
    }
    if (index == 1) {
      gitTuketimRaporu();
    }
    if (index == 2) {
      _gitVKI();
    }
    if (index == 3) {
      gitAyarlar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: const Text(
            'Formda Kal',
            style: TextStyle(
              letterSpacing: 1.2,
              color: Color.fromRGBO(56, 36, 105, 1),
            ),
          ),
          actions: <Widget>[
            //Ekip Bilgileri Butonu
            IconButton(
              icon: const Icon(
                Icons.group_outlined,
                color: Color.fromRGBO(56, 36, 105, 1),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Grup(
                    Email: _myemail,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.bell,
                color: Color.fromRGBO(56, 36, 105, 1),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Istek()),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          iconSize: 30,
          selectedColor: Color.fromRGBO(56, 36, 105, 1),
          strokeColor: Color.fromRGBO(187, 172, 255, 1),
          unSelectedColor: Color.fromRGBO(187, 172, 255, 0.6),
          backgroundColor: Colors.white,
          borderRadius: Radius.circular(20.0),
          isFloating: true,
          items: [
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.tint),
            ),
            CustomNavigationBarItem(
              icon: Icon(CommunityMaterialIcons.google_analytics),
            ),
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.weight),
            ),
            CustomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.cog),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) => onTabChange(index),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: SingleChildScrollView(child: _body),
          ),
        ),
      ),
    );
  }

  _gitSuIc() {
    suKontrol();
    setState(
      () {
        _body = SuIc(
          value: _value,
          tuketilen_su: _tuketilen_su,
          ay: _ay,
          gun: _gun,
          tarihRef: tarihRef,
        );
      },
    );
  }

  _gitVKI() {
    setState(
      () {
        _body = VKI_goruntule();
      },
    );
  }

  gitTuketimRaporu() {
    setState(() {
      _body = TuketimRaporu(
        Email: _myemail,
        ay: _ay,
        gun: _gun,
        tarihRef: tarihRef,
      );
    });
  }

  gitAyarlar() {
    setState(() {
      _body = Ayarlar();
    });
  }
}
