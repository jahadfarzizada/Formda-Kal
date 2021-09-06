import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:formda_kal/sayfalar/vki_hesapla.dart';

import '../constants/constants.dart';
import 'oturum_aç.dart';

class HesapAc extends StatefulWidget {
  @override
  _HesapAcState createState() => _HesapAcState();
}

class _HesapAcState extends State<HesapAc> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late String _ad_soyad;

  Widget _buildAdSoyad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Ad Soyad',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            style: TextStyle(
              color: Color.fromRGBO(56, 36, 105, 1),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Color.fromRGBO(56, 36, 105, 0.5),
              ),
              hintText: 'Ad Soyad Giriniz',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (x) {
              setState(() {
                _ad_soyad = x;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Color.fromRGBO(56, 36, 105, 1),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Color.fromRGBO(56, 36, 105, 0.5),
              ),
              hintText: 'örnek@mail.com',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSifreTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Şifre',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Color.fromRGBO(56, 36, 105, 1),
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color.fromRGBO(56, 36, 105, 0.5),
              ),
              hintText: 'Şifrenizi Giriniz',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKaydolBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: () => kayitOl(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'KAYDOL',
          style: TextStyle(
            color: Color.fromRGBO(56, 36, 105, 0.8),
            letterSpacing: 3,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildOturumAcBtn() {
    return GestureDetector(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Hesabınız Var mı? ',
              style: TextStyle(
                color: Color.fromRGBO(56, 36, 105, 1),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Oturum Aç',
              style: TextStyle(
                color: Color.fromRGBO(56, 36, 105, 1),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => OturumAc()),
            (Route<dynamic> route) => false);
      },
    );
  }

  Future<void> kayitOl() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(), //email adresini al
            password: passwordController.text.trim(), //şifreyi al
          )
          .then(
            (value) => Navigator.pushAndRemoveUntil(
                //Kayıt tamamlandıktan sonra VKI hesapla
                context,
                MaterialPageRoute(
                    builder: (_) => Vki_Hesapla(
                        sayfa_kontrol: false,
                        Email: emailController.text.trim(),
                        AdSoyad: _ad_soyad)),
                (Route<dynamic> route) => false),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //şifre zayıfsa hata ver
        print('Şifreniz zayıf');
      } else if (e.code == 'email-already-in-use') {
        // bu mail adresi daha önce kullanılmışsa hata ver
        print('Bu email ile daha önce hesap açılmış.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFe9defa),
                    Color(0xFFfbfcdb),
                  ],
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.7, sigmaY: 1.7),
              child: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Hesap Aç',
                        style: TextStyle(
                            letterSpacing: 2,
                            color: Color.fromRGBO(56, 36, 105, 1),
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30.0),
                      _buildAdSoyad(),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(height: 30.0),
                      _buildSifreTF(),
                      _buildKaydolBtn(),
                      _buildOturumAcBtn(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
