import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formda_kal/sayfalar/govde.dart';
import 'package:formda_kal/servisler/auth_service.dart';
import 'package:provider/provider.dart';

import 'sayfalar/oturum_aç.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(FormdaKal());
  });
}

class FormdaKal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Directionality(
              textDirection: TextDirection.ltr, child: child as Widget);
        },
        theme: new ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            fontFamily: 'Baloo2',
            textTheme: TextTheme(
              subtitle1: TextStyle(
                letterSpacing: 1.5,
                color: Colors.black38,
                fontSize: 20,
              ),
              subtitle2: TextStyle(
                color: Color(0xFFfff2c2),
                fontSize: 17,
              ),
            ),
            snackBarTheme: SnackBarThemeData(
              backgroundColor: Color.fromRGBO(56, 36, 105, 1),
              actionTextColor: Colors.white,
              disabledActionTextColor: Colors.grey,
              contentTextStyle: TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              behavior: SnackBarBehavior.floating,
            )),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Govde();
          } else
            return OturumAc();
        });
  }
}
