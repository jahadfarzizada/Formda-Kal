import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';
import 'oturum_aç.dart';

class SifreSifirla extends StatefulWidget {
  @override
  _SifreSifirlaState createState() => _SifreSifirlaState();
}

class _SifreSifirlaState extends State<SifreSifirla> {
  final TextEditingController emailController = TextEditingController();

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Kayıtlı email adresinizi giriniz',
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

  Widget _buildIstekGonderBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: () => FirebaseAuth.instance
            .sendPasswordResetEmail(
                email: emailController.text.trim()) //emaile istek gönder
            .then(
              //sonra Oturum Aç sayfasına geri dön
              (value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => OturumAc()),
                  (Route<dynamic> route) => false),
            ),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'İstek Gönder',
          style: TextStyle(
            color: Color.fromRGBO(56, 36, 105, 1),
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
              text: 'Bir işlem yapmak istemiyorsanız geri dönün: ',
              style: TextStyle(
                color: Color.fromRGBO(56, 36, 105, 1),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Oturum Aç',
              style: TextStyle(
                color: Color.fromRGBO(56, 36, 105, 1),
                fontSize: 16,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
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
                          height: 200,
                        ),
                        Text(
                          'Şifrenizi Sıfırlayın',
                          style: TextStyle(
                              letterSpacing: 2,
                              color: Color.fromRGBO(56, 36, 105, 1),
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30.0),
                        _buildEmailTF(),
                        SizedBox(height: 30.0),
                        _buildIstekGonderBtn(),
                        _buildOturumAcBtn(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
