import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formda_kal/constants/tuketim.dart';

class TuketimRaporu extends StatefulWidget {
  String? Email;
  String ay, gun;
  CollectionReference tarihRef;
  TuketimRaporu({
    Key? key,
    required this.Email,
    required this.ay,
    required this.gun,
    required this.tarihRef,
  }) : super(key: key);

  @override
  _TuketimRaporuState createState() => _TuketimRaporuState();
}

class _TuketimRaporuState extends State<TuketimRaporu> {
  late List<charts.Series<Tuketim, String>> _seriesBarData;
  late List<Tuketim> mydata;
  var _ortalama;
  var _hedefSayisi;
  var _yuksekSonuc;

  void initState() {
    super.initState();
    hedefKontrol();
    ortHesapla();
    yuksekSonucHesapla();
  }

  hedefKontrol() {
    widget.tarihRef
        .doc(widget.ay)
        .collection(widget.Email!)
        .where('hedef_tamamlandı', isEqualTo: true)
        .get()
        .then(
      (value) {
        setState(() {
          _hedefSayisi = value.docs.length;
        });
      },
    );
  }

  ortHesapla() {
    widget.tarihRef.doc(widget.ay).collection(widget.Email!).get().then(
      (value) {
        final toplam_gun = value.docs.length;
        int i;
        num ort = 0;
        for (i = 0; i < toplam_gun; i++) {
          ort = ort + value.docs[i]['Tüketilen'];
        }
        setState(() {
          _ortalama = ort / toplam_gun;
        });
      },
    );
  }

  yuksekSonucHesapla() {
    widget.tarihRef
        .doc(widget.ay)
        .collection(widget.Email!)
        .orderBy('Tüketilen', descending: true)
        .get()
        .then((value) {
      setState(() {
        _yuksekSonuc = value.docs[0]['Tüketilen'];
      });
    });
  }

  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Tuketim, String>>.empty(growable: true);
    _seriesBarData.add(
      charts.Series(
        domainFn: (Tuketim tuketim, _) => tuketim.tuketimGun.toString(),
        measureFn: (Tuketim tuketim, _) => tuketim.tuketimMiktar,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Color.fromRGBO(56, 36, 105, 0.8)),
        id: 'Tuketim',
        data: mydata,
        labelAccessorFn: (Tuketim row, _) => "${row.tuketimGun}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 450.0,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: widget.tarihRef
                        .doc(widget.ay)
                        .collection(widget.Email!)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 1.3,
                          alignment: FractionalOffset.center,
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(56, 36, 105, 1),
                          ),
                        );
                      } else {
                        List<Tuketim> tuketilenSu = snapshot.data!.docs
                            .map((documentSnapshot) => Tuketim.fromMap(
                                documentSnapshot.data()
                                    as Map<String, dynamic>))
                            .toList();
                        return _buildChart(context, tuketilenSu);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _buildContainer(context),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildChart(BuildContext context, List<Tuketim> tuketimVerisi) {
    mydata = tuketimVerisi;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        height: 400,
        padding: EdgeInsets.all(20),
        child: Card(
          color: Color.fromRGBO(248, 248, 246, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Bu Ayın Sıvı Tüketim Grafiği",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    color: Color.fromRGBO(56, 36, 105, 1),
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: charts.BarChart(
                    _seriesBarData,
                    animate: true,
                    animationDuration: Duration(seconds: 1), //animasyon süresi
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('Kullanicilar')
          .doc(widget.Email)
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
        return Container(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 180,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 15,
                          left: 20,
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("images/icons/calendar.png"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerLeft),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 80,
                          child: Text(
                            'Aylık Hedef\nBaşarısı',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 10,
                          endIndent: 10,
                          height: 150,
                          color: Colors.white54,
                        ),
                        Positioned(
                          top: 90,
                          left: 52,
                          child: Text(
                            _hedefSayisi.toString() + ' Gün',
                            style: TextStyle(
                                letterSpacing: 1.2,
                                color: Colors.white,
                                fontSize: 27),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 180,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 15,
                          left: 20,
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/icons/flag.png"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerLeft),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 90,
                          child: Text(
                            'Şuanki\nHedef',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 10,
                          endIndent: 10,
                          height: 150,
                          color: Colors.white54,
                        ),
                        Positioned(
                          top: 90,
                          left: 35,
                          child: Text(
                            doc!['Hedef'].toString() + ' ml',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Colors.white,
                              fontSize: 27,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 180,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 15,
                          left: 20,
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/icons/average.png"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerLeft),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 27,
                          left: 85,
                          child: Text(
                            'Aylık\nOrtalama',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 10,
                          endIndent: 10,
                          height: 150,
                          color: Colors.white54,
                        ),
                        Positioned(
                          top: 90,
                          left: 35,
                          child: Text(
                            _ortalama.toStringAsFixed(0) + ' ml',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Colors.white,
                              fontSize: 27,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 180,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 15,
                          left: 20,
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/icons/summit.png"),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerLeft),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 80,
                          child: Text(
                            'En Yüksek\nSonuç',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 10,
                          endIndent: 10,
                          height: 150,
                          color: Colors.white54,
                        ),
                        Positioned(
                          top: 90,
                          left: 35,
                          child: Text(
                            _yuksekSonuc.toString() + ' ml',
                            style: TextStyle(
                              letterSpacing: 1.2,
                              color: Colors.white,
                              fontSize: 27,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
