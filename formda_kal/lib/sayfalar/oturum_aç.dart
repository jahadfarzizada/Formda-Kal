import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formda_kal/sayfalar/%C5%9FifreS%C4%B1f%C4%B1rla.dart';
import 'package:formda_kal/servisler/auth_service.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import 'hesap_aç.dart';

class OturumAc extends StatefulWidget {
  @override
  _OturumAcState createState() => _OturumAcState();
}

class _OturumAcState extends State<OturumAc> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  Widget _buildForgotSifreBtn() {
    return Container(
      alignment: Alignment.centerRight,
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SifreSifirla()),
            (Route<dynamic> route) => false),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Şifrenizi mi unuttunuz?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildGirisYapBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: () {
          context.read<AuthenticationService>().signIn(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Giriş Yap',
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

  Widget _buildHesapAcBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HesapAc()),
            (Route<dynamic> route) => false);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Hesabınız Yok mu? ',
              style: TextStyle(
                color: Color.fromRGBO(56, 36, 105, 1),
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Yeni Hesap Aç',
              style: TextStyle(
                color: Color.fromRGBO(56, 36, 105, 1),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
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
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 120.0),
                    Text(
                      'Oturum Aç',
                      style: TextStyle(
                          letterSpacing: 2,
                          color: Color.fromRGBO(56, 36, 105, 1),
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30.0),
                    _buildEmailTF(),
                    SizedBox(height: 30.0),
                    _buildSifreTF(),
                    _buildForgotSifreBtn(),
                    _buildGirisYapBtn(),
                    _buildHesapAcBtn(),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
