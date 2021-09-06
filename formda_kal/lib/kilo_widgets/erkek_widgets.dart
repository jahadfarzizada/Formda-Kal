import 'package:flutter/cupertino.dart';

class zayif_erkek extends StatelessWidget {
  const zayif_erkek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 450,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 25,
            left: 25,
            child: Image.asset(
              'images/img/zayif.png',
              width: 120,
            ),
          ),
          Positioned(
            top: 40,
            left: 170,
            child: Container(
              width: 270,
              height: 350,
              child: Column(
                children: [
                  Text(
                    '18.5 altında: Zayıf',
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1.5,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    'Az miktarda vücut yağına sahipsiniz.Eğer atletseniz bu istenebilir bir durumdur; fakat değilseniz zayıf VKİ seviyesi vücut ağırlığınızın düşük olduğunu gösterir ve bağışıklık sisteminizin zayıflamasına sebep olabilir. Eğer VKİ’niz ve vücut ağırlığınız düşükse kas hacminizi artırmak için sağlıklı bir beslenme ve egzersiz yoluyla kilo almaya çalışmalısınız.',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.3,
                      fontFamily: 'OpenSans',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class normal_erkek extends StatelessWidget {
  const normal_erkek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 450,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 25,
            left: 25,
            child: Image.asset(
              'images/img/normal.png',
              width: 120,
            ),
          ),
          Positioned(
            top: 40,
            left: 170,
            child: Container(
              width: 270,
              height: 350,
              child: Column(
                children: [
                  Text(
                    '18.5 - 24.9 arası: Normal',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    'İdeal miktarda vücut yağına sahip olduğunuz anlamına gelir ve bu da uzun ve ciddi hastalık oranın en az olduğu bir hayat demektir. Aynı zamanda bu oran birçok insanın estetik olarak en çekici bulduğu orandır.',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.3,
                      fontFamily: 'OpenSans',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class kilolu_erkek extends StatelessWidget {
  const kilolu_erkek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 450,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            left: 5,
            child: Image.asset(
              'images/img/kilolu.png',
              width: 150,
            ),
          ),
          Positioned(
            top: 40,
            left: 170,
            child: Container(
              width: 270,
              height: 350,
              child: Column(
                children: [
                  Text(
                    '25.0-29.9 arası: Kilolu',
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1.5,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    'Kilolusunuz, diyet ve egzersizle kilo vermenin yollarını aramalısınız. Şu anki kilonuzla çeşitli hastalıklar için risk taşımaktasınız. Beslenme stilinizi değiştirerek ve egzersize daha fazla ağırlık vererek kilo vermelisiniz.',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.3,
                      fontFamily: 'OpenSans',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class obez_erkek extends StatelessWidget {
  const obez_erkek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 450,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            left: 5,
            child: Image.asset(
              'images/img/obez.png',
              width: 150,
            ),
          ),
          Positioned(
            top: 40,
            left: 170,
            child: Container(
              width: 270,
              height: 350,
              child: Column(
                children: [
                  Text(
                    '30.0 - 34.9 arası: Obez',
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1.5,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    'Obez kategorisindesiniz. Sağlıksız bir kilonuz var, bunun getirdiği ve getireceği sağlık sorunlarıyla karşı karşıyasınız demektir. Beslenme stilinizi değiştirerek ve egzersize daha fazla ağırlık vererek kilo vermelisiniz.',
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.3,
                      fontFamily: 'OpenSans',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class asiri_obez_erkek extends StatelessWidget {
  const asiri_obez_erkek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 450,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 10,
            child: Image.asset(
              'images/img/asiri_obez.png',
              width: 147,
            ),
          ),
          Positioned(
            top: 40,
            left: 170,
            child: Container(
              width: 270,
              height: 350,
              child: Column(
                children: [
                  Text(
                    '35 ve üzeri arası: Aşırı Obez',
                    style: TextStyle(
                      fontSize: 22,
                      letterSpacing: 1.5,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Text(
                    'Aşırı Obez kategorisindesiniz. Sağlıksız bir kilonuz var, bunun getirdiği ve getireceği sağlık sorunlarıyla karşı karşıyasınız demektir. Beslenme stilinizi değiştirerek ve egzersize daha fazla ağırlık vererek kilo vermelisiniz.',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
