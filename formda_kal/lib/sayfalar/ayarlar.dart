import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:formda_kal/constants/constants.dart';
import 'package:formda_kal/sayfalar/vki_hesapla.dart';
import 'package:formda_kal/servisler/bildirim.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'oturum_aç.dart';

class Ayarlar extends StatefulWidget {
  Ayarlar({Key? key}) : super(key: key);

  @override
  _AyarlarState createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  String? _myemail =
      FirebaseAuth.instance.currentUser!.email; //şuanki kullanıcının emaili
  final TextEditingController hedefController = TextEditingController();

  LocalNotification _bildirim = new LocalNotification();

  bool su_status = false;
  bool spor_status = false;
  bool bilgi_status = false;

  final _hedefSnackBar = SnackBar(
    content: Text('Hedef başarılı bir şekilde güncellendi.'),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSwitchValues();
    _bildirim.setOnNotificationReceive(onNotificationReceive);
    _bildirim.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotifications notifications) {
    print('Bildirim Başarılı ${notifications.id}');
  }

  onNotificationClick(String? payload) {
    print('Payload $payload');
  }

  getSwitchValues() async {
    su_status = (await suStatusAl())!;
    spor_status = (await sporStatusAl())!;
    bilgi_status = (await bilgiStatusAl())!;
    setState(() {});
  }

  Future<bool> suStatusTut(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("su", value);

    return prefs.setBool("su", value);
  }

  Future<bool?> suStatusAl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? su_status = prefs.getBool("su");

    return su_status;
  }

  Future<bool> sporStatusTut(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("spor", value);

    return prefs.setBool("spor", value);
  }

  Future<bool?> sporStatusAl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? spor_status = prefs.getBool("spor");

    return spor_status;
  }

  Future<bool> bilgiStatusTut(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("bilgi", value);

    return prefs.setBool("bilgi", value);
  }

  Future<bool?> bilgiStatusAl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? bilgi_status = prefs.getBool("bilgi");

    return bilgi_status;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Kullanicilar')
          .doc(_myemail)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.3,
            alignment: FractionalOffset.center,
            child: CircularProgressIndicator(
              color: Color.fromRGBO(56, 36, 105, 1),
            ),
          );
        }
        var doc = snapshot.data;
        return SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  child: Container(
                    width: 450,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(248, 248, 246, 1),
                      border:
                          Border.all(color: Color.fromRGBO(187, 172, 255, 0.1)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          doc!['Ad Soyad'],
                          style: TextStyle(
                            letterSpacing: 1.2,
                            color: Color.fromRGBO(56, 36, 105, 0.8),
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 80,
                            ),
                            Text(
                              'Boy: ' + doc['Boy'].toString(),
                              style: TextStyle(
                                letterSpacing: 1.2,
                                color: Color.fromRGBO(56, 36, 105, 0.7),
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Kilo: ' + doc['Kilo'].toString(),
                              style: TextStyle(
                                letterSpacing: 1.2,
                                color: Color.fromRGBO(56, 36, 105, 0.7),
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'VKI: ' + doc['VKI'].round().toString(),
                              style: TextStyle(
                                letterSpacing: 1.2,
                                color: Color.fromRGBO(56, 36, 105, 0.7),
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Vki_Hesapla(
                          sayfa_kontrol: true,
                          Email: doc['Email'],
                          AdSoyad: doc['Ad Soyad']),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                    width: 450,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(248, 248, 246, 1),
                      border:
                          Border.all(color: Color.fromRGBO(187, 172, 255, 0.1)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Hedef: ' + doc['Hedef'].toString() + ' ml',
                          style: TextStyle(
                            letterSpacing: 1.2,
                            color: Color.fromRGBO(56, 36, 105, 0.8),
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => _hedefPopup(context),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 450,
                  height: 215,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(248, 248, 246, 1),
                    border:
                        Border.all(color: Color.fromRGBO(187, 172, 255, 0.1)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            'Su Hatırlatıcı',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Color.fromRGBO(56, 36, 105, 0.8),
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                          ),
                          CustomSwitch(
                            activeColor: Colors.green,
                            value: su_status,
                            onChanged: (value) {
                              su_status = value;
                              suStatusTut(value);
                              _bildirimAyarla(value, 'su');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7.5,
                      ),
                      Divider(
                        color: Colors.black38,
                        height: 15,
                        indent: 50,
                        endIndent: 50,
                      ),
                      SizedBox(
                        height: 7.5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            'Spor Hatırlatıcı',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Color.fromRGBO(56, 36, 105, 0.8),
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            width: 128.5,
                          ),
                          CustomSwitch(
                            activeColor: Colors.green,
                            value: spor_status,
                            onChanged: (value) {
                              spor_status = value;
                              sporStatusTut(value);
                              _bildirimAyarla(value, 'spor');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7.5,
                      ),
                      Divider(
                        color: Colors.black38,
                        height: 15,
                        indent: 50,
                        endIndent: 50,
                      ),
                      SizedBox(
                        height: 7.5,
                      ),
                      SizedBox(
                        height: 7.5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            'Günlük Faydalı Bilgiler',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Color.fromRGBO(56, 36, 105, 0.8),
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            width: 56,
                          ),
                          CustomSwitch(
                            activeColor: Colors.green,
                            value: bilgi_status,
                            onChanged: (value) {
                              bilgi_status = value;
                              bilgiStatusTut(value);
                              _bildirimAyarla(value, 'bilgi');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _buildOturumKapatBtn()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOturumKapatBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 400,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: () => oturumuKapat(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.redAccent,
        child: Text(
          'Oturumu Kapat',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 3,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  _bildirimAyarla(value, bildirim_turu) async {
    if (bildirim_turu == 'su') {
      if (value == true) {
        await _bildirim.saatlikBildirimGonder(
          0,
          'Sağlıklı Yaşam İçin, Su İçin!',
          'Hedefinize ulaşmak için, su içmeyi unutmayın.',
          'https://images.unsplash.com/photo-1517559421643-54bc2e32021c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80',
          "payload",
        );
      } else {
        _bildirim.deleteNotificationPlan(0);
      }
    } else if (bildirim_turu == 'spor') {
      if (value == true) {
        await _bildirim.gunlukBildirimGonder(
          1,
          'Sporunuzu Yapmayı Unutmayın',
          'Daha sağlıklı olmak ve formda kalmak için, günlük sporunuzu yapmayı ihmal etmeyin.',
          Time(8, 30, 0),
          'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=889&q=80',
          "payload",
        );
      } else {
        _bildirim.deleteNotificationPlan(1);
      }
    } else {
      if (value == true) {
        await _bildirim.gunlukBildirimGonder(
          2,
          'Biliyor muydunuz?',
          'Günde 8 bardak su içmek; Metabolizmayı daha fazla çalıştırır. Böylece daha fazla kalori yakmış olursunuz. Ilık su, aynı zamanda vücuttaki yağların parçalanmasını sağlar.',
          Time(10, 30, 0),
          'https://images.unsplash.com/photo-1535914254981-b5012eebbd15?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
          "payload",
        );
      } else {
        _bildirim.deleteNotificationPlan(2);
      }
    }
  }

  _hedefPopup(context) {
    Alert(
        style: AlertStyle(
          alertElevation: 20,
          animationType: AnimationType.fromBottom,
          descStyle: TextStyle(fontWeight: FontWeight.bold),
          descTextAlign: TextAlign.start,
          animationDuration: Duration(milliseconds: 500),
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          titleStyle: TextStyle(
            color: Color.fromRGBO(56, 36, 105, 0.8),
            letterSpacing: 3,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
          alertAlignment: Alignment.center,
        ),
        context: context,
        title: "Hedef Güncelle",
        content: Container(
          width: 300,
          height: 120,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white54,
                  border: Border.all(color: Color.fromRGBO(187, 172, 255, 0.2)),
                ),
                height: 60.0,
                child: TextField(
                  controller: hedefController,
                  style: TextStyle(
                    color: Color.fromRGBO(56, 36, 105, 1),
                    fontFamily: 'OpenSans',
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.flag_outlined,
                      color: Color.fromRGBO(56, 36, 105, 0.5),
                    ),
                    hintText: 'Yeni Hedefinizi Giriniz',
                    hintStyle: kHintTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Kullanicilar')
                  .doc(_myemail)
                  .update(
                    //kullanıcı bilgilerini göncelle
                    {
                      'Hedef': hedefController.text.trim(),
                    },
                  )
                  .whenComplete(() => Navigator.pop(context))
                  .then(
                    (value) => ScaffoldMessenger.of(context)
                        .showSnackBar(_hedefSnackBar),
                  ); //bittiğinde kapan
            },
            color: Colors.white,
            child: Text(
              "Güncelle",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 3,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF2b5876),
                Color(0xFF4e4376),
              ],
            ),
          )
        ]).show();
  }

  oturumuKapat() async {
    await FirebaseAuth.instance.signOut().then(
      (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => OturumAc()),
            (Route<dynamic> route) => false);
      },
    );
  }
}
