import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_ns/liquid_progress_indicator.dart';

class SuIc extends StatefulWidget {
  double value;
  var tuketilen_su;
  String ay, gun;
  CollectionReference tarihRef;

  SuIc({
    Key? key,
    required this.value,
    this.tuketilen_su,
    required this.ay,
    required this.gun,
    required this.tarihRef,
  }) : super(key: key);

  @override
  _SuIcState createState() => _SuIcState();
}

class _SuIcState extends State<SuIc> {
  String? _myemail =
      FirebaseAuth.instance.currentUser!.email; //şuanki kullanıcının emaili

  @override
  void initState() {
    super.initState();
  }

  hedefKontrol(int hedef) {
    widget.tarihRef
        .doc(widget.ay)
        .collection(_myemail!)
        .doc(widget.gun)
        .snapshots()
        .listen(
      (doc) {
        if (doc['Tüketilen'] >= hedef) {
          //hedef tamamlanmışsa güncelle
          widget.tarihRef
              .doc(widget.ay)
              .collection(_myemail!)
              .doc(widget.gun)
              .update(
            {
              'hedef_tamamlandı': true,
            },
          );
        }
      },
    );
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
        final ml = widget.value * int.parse(doc!['Hedef']);
        return SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Tüketilen Sıvı Miktarı",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    color: Color.fromRGBO(56, 36, 105, 1),
                    fontSize: 40.0,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Stack(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 450.0,
                        height: 450.0,
                        child: LiquidCircularProgressIndicator(
                          value: widget.value,
                          backgroundColor: Color.fromRGBO(240, 247, 255, 1),
                          valueColor: AlwaysStoppedAnimation(
                            Color.fromRGBO(187, 172, 255, 1),
                          ),
                          borderColor: Color.fromRGBO(240, 247, 255, 1),
                          borderWidth: 5.0,
                          center: Column(
                            children: [
                              SizedBox(
                                height: 185,
                              ),
                              Text(
                                "${ml.toStringAsFixed(0)}ml",
                                style: TextStyle(
                                  color: Color.fromRGBO(56, 36, 105, 1),
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                doc['Hedef'].toString() + 'ml',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 220,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(241, 238, 255, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 25,
                              left: 35,
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/icons/cup.png"),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 100,
                              child: Text(
                                '100ml',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        suEkle(100, int.parse(doc['Hedef']));
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 220,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(248, 248, 246, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 25,
                              left: 35,
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("images/icons/water.png"),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.centerLeft),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 100,
                              child: Text(
                                '200ml',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        suEkle(200, int.parse(doc['Hedef']));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 220,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 250, 236, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 25,
                              left: 35,
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "images/icons/plastic-bottle.png"),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.centerLeft),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 100,
                              child: Text(
                                '500ml',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        suEkle(500, int.parse(doc['Hedef']));
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Container(
                        width: 220,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(251, 233, 227, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 25,
                              left: 35,
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "images/icons/measuring-cup.png"),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.centerLeft),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 100,
                              child: Text(
                                '750ml',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        suEkle(750, int.parse(doc['Hedef']));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  suEkle(int miktar, int hedef) {
    setState(() {
      widget.value = widget.value + (miktar / hedef);
      widget.tuketilen_su = widget.tuketilen_su + miktar;
    });
    widget.tarihRef.doc(widget.ay).collection(_myemail!).doc(widget.gun).set(
      {
        'Gün': int.parse(widget.gun),
        'Hedef': hedef,
        'Tüketilen': widget.tuketilen_su,
        'hedef_tamamlandı': false,
      },
    ).then((value) => hedefKontrol(hedef)); //hedefi kontrol et
  }
}
