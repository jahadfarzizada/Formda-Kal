import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formda_kal/sayfalar/tuketim_raporu.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Grup extends StatefulWidget {
  String? Email;
  Grup({Key? key, required this.Email}) : super(key: key);

  @override
  _GrupState createState() => _GrupState();
}

class _GrupState extends State<Grup> {
  CollectionReference tarihRef =
      FirebaseFirestore.instance.collection('Tarihler');

  final TextEditingController mailController = TextEditingController();

  final _istekSnackBar = SnackBar(
    content: Text('Grup isteği başarılı bir şekilde gönderildi.'),
  );
  final _silSnackBar = SnackBar(
    content: Text('Kullanıcı gruptan çıkarıldı.'),
  );

  late Widget _body;
  late String _ay, _gun;
  var title;

  void initState() {
    super.initState();
    tarihKontrol();
    _body = _buildBody(context);
    title = ' ';
  }

  tarihKontrol() async {
    final now = new DateTime.now();
    setState(() {
      _ay = new DateFormat.MMM().format(now);
      _gun = new DateFormat.d().format(now);
    });
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
          title: Text(
            'Formda Kal' + title,
            style: TextStyle(
              letterSpacing: 1.2,
              color: Color.fromRGBO(56, 36, 105, 1),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromRGBO(56, 36, 105, 1),
          tooltip: 'Ekle',
          child: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
          onPressed: () => _eklePopup(context),
        ),
        body: _body,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Gruplar')
          .doc(widget.Email)
          .collection('Kullanıcı Gurubu')
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
        }
        var doc = snapshot.data!.docs;
        if (doc.length == 0) {
          return Center(
            child: Text(
              '...Grubunuzda Kimse Bulunmuyor...',
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
                childAspectRatio: 30 / 9.0,
                children: doc.map(
                  (doc) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _body = Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.white),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: SingleChildScrollView(
                                child: TuketimRaporu(
                                    Email: doc['Email'],
                                    ay: _ay,
                                    gun: _gun,
                                    tarihRef: tarihRef),
                              ),
                            ),
                          );
                          title = ' - ' + doc['Ad Soyad'];
                        });
                      },
                      child: Card(
                        color: Color.fromRGBO(56, 36, 105, 1),
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Positioned(
                              left: 400,
                              child: IconButton(
                                icon:
                                    Icon(CommunityMaterialIcons.account_remove),
                                onPressed: () {
                                  Sil(doc['Email']);
                                },
                                iconSize: 25,
                                color: Colors.white54,
                              ),
                            ),
                            Positioned(
                              top: 25,
                              child: Text(
                                doc['Ad Soyad'],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              child: Text(
                                '( ' + doc['Email'] + ' )',
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontFamily: 'OpenSans',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              left: 100,
                              child: Text(
                                'Boy: ' + doc['Boy'].toString(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              left: 200,
                              child: Text(
                                'Kilo: ' + doc['Kilo'].toString(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              left: 300,
                              child: Text(
                                'VKI: ' + doc['VKI'].round().toString(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              )),
            ),
          );
        }
      },
    );
  }

  _eklePopup(context) {
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
        title: "Gruba Ekle",
        content: Container(
          width: 300,
          height: 120,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                'Grubunuza eklemek istediğiniz kişinin mail adresini giriniz',
                style: TextStyle(
                  color: Color.fromRGBO(56, 36, 105, 0.8),
                  fontSize: 12,
                  fontFamily: 'OpenSans',
                ),
              ),
              SizedBox(
                height: 7,
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
                  controller: mailController,
                  style: TextStyle(
                      color: Color.fromRGBO(56, 36, 105, 1),
                      fontFamily: 'OpenSans',
                      fontSize: 15),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Color.fromRGBO(56, 36, 105, 0.5),
                    ),
                    hintText: 'örnek@mail.com',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                    ),
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
                  .collection('Istekler')
                  .doc(mailController.text.trim())
                  .collection('Grub Istekleri')
                  .doc(widget.Email)
                  .set({
                    'Email': widget.Email,
                  })
                  .whenComplete(() => Navigator.pop(context))
                  .then((value) => ScaffoldMessenger.of(context)
                      .showSnackBar(_istekSnackBar)); //bittiğinde kapan
            },
            color: Colors.white,
            child: Text(
              "Istek Gönder",
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

  Sil(String email) {
    FirebaseFirestore.instance
        .collection('Gruplar') //Istekler koleksiyonundan bu isteği sil
        .doc(widget.Email)
        .collection('Kullanıcı Gurubu')
        .doc(email)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    }).whenComplete(
            () => ScaffoldMessenger.of(context).showSnackBar(_silSnackBar));
  }
}
