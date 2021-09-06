import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Istek extends StatefulWidget {
  const Istek({Key? key}) : super(key: key);

  @override
  _IstekState createState() => _IstekState();
}

class _IstekState extends State<Istek> {
  String? _myemail =
      FirebaseAuth.instance.currentUser!.email; //şuanki kullanıcının emaili

  final _OnaySnackBar = SnackBar(
    content: Text('Istek Onaylandı!'),
  );
  final _ReddSnackBar = SnackBar(
    content: Text('Istek Reddedildi!'),
  );

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
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Istekler')
          .doc(_myemail)
          .collection('Grub Istekleri')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.3,
            alignment: FractionalOffset.center,
            child: CircularProgressIndicator(
              color: Color.fromRGBO(56, 36, 105, 1),
            ),
          );
        }
        var doc = snapshot.data!.docs;
        if (doc.length == 0) {
          return Center(
            child: Text(
              '...Istek Kutunuz Boş...',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1.2,
                color: Color.fromRGBO(56, 36, 105, 0.5),
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SingleChildScrollView(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 1,
                  padding: EdgeInsets.all(15),
                  childAspectRatio: 60 / 9.0,
                  children: doc.map(
                    (doc) {
                      return Card(
                        color: Color.fromRGBO(56, 36, 105, 1),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 19,
                              left: 19,
                              width: 130,
                              child: AutoSizeText(
                                doc['Email'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 19,
                              left: 160,
                              width: 220,
                              child: Text(
                                'size grup isteği gönderdi.',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 350,
                              child: IconButton(
                                icon: Icon(Icons.check_circle_rounded),
                                onPressed: () {
                                  Onayla(doc['Email']);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(_OnaySnackBar);
                                },
                                iconSize: 30,
                                color: Colors.green,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 397,
                              child: IconButton(
                                icon: Icon(Icons.remove_circle),
                                onPressed: () {
                                  reddEt(doc['Email']);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(_ReddSnackBar);
                                },
                                iconSize: 30,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> Onayla(String email) async {
    await FirebaseFirestore.instance
        .collection("Kullanicilar")
        .doc(email)
        .snapshots()
        .listen(
      (doc) {
        FirebaseFirestore.instance
            .collection('Gruplar')
            .doc(_myemail)
            .collection('Kullanıcı Gurubu')
            .doc(email)
            .set({
          'Email': email,
          'Ad Soyad': doc['Ad Soyad'],
          'Boy': doc['Boy'],
          'Kilo': doc['Kilo'],
          'VKI': doc['VKI'],
        });
      },
    );
    await FirebaseFirestore.instance
        .collection("Kullanicilar")
        .doc(_myemail)
        .snapshots()
        .listen(
      (doc) {
        FirebaseFirestore.instance
            .collection('Gruplar')
            .doc(email)
            .collection('Kullanıcı Gurubu')
            .doc(_myemail)
            .set({
          'Email': _myemail,
          'Ad Soyad': doc['Ad Soyad'],
          'Boy': doc['Boy'],
          'Kilo': doc['Kilo'],
          'VKI': doc['VKI'],
        });
      },
    );
    reddEt(email);
  }

  reddEt(String email) {
    FirebaseFirestore.instance
        .collection('Istekler') //Istekler koleksiyonundan bu isteği sil
        .doc(_myemail)
        .collection('Grub Istekleri')
        .doc(email)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }
}
