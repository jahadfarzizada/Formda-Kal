import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formda_kal/kilo_widgets/erkek_widgets.dart';
import 'package:formda_kal/kilo_widgets/kadin_widgets.dart';

class VKI_goruntule extends StatefulWidget {
  VKI_goruntule({Key? key}) : super(key: key);

  @override
  _VKI_goruntuleState createState() => _VKI_goruntuleState();
}

class _VKI_goruntuleState extends State<VKI_goruntule> {
  String? _email = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Kullanicilar')
          .doc(_email)
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
                  height: 20,
                ),
                Text(
                  'Vucut Kütle İndeksiniz',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 35,
                    color: Color.fromRGBO(56, 36, 105, 1),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 450,
                  height: 350,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromRGBO(187, 172, 255, 0.19)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        doc!['VKI'].round().toString(),
                        style: TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 100,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset('images/img/vki_araligi.png'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                buildKiloWidget(doc['VKI'], doc['Cinsiyet']),
              ],
            ),
          ),
        );
      },
    );
  }

  buildKiloWidget(vki, cinsiyet) {
    if (vki < 18.5) {
      if (cinsiyet == 'Erkek') {
        return zayif_erkek();
      } else {
        return zayif_kadin();
      }
    } else if (vki > 18.5 && vki < 24.9) {
      if (cinsiyet == 'Erkek') {
        return normal_erkek();
      } else {
        return normal_kadin();
      }
    } else if (vki > 25 && vki < 29.9) {
      if (cinsiyet == 'Erkek') {
        return kilolu_erkek();
      } else {
        return kilolu_kadin();
      }
    } else if (vki > 30 && vki < 34.9) {
      if (cinsiyet == 'Erkek') {
        return obez_erkek();
      } else {
        return obez_kadin();
      }
    } else if (vki > 35) {
      if (cinsiyet == 'Erkek') {
        return asiri_obez_erkek();
      } else {
        return asiri_obez_kadin();
      }
    }
  }
}
