import 'package:flutter/cupertino.dart';

class zayif_kadin extends StatelessWidget {
  const zayif_kadin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 500,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 25,
            left: 25,
            child: Image.asset(
              'images/img/zayif_kadin.png',
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

class normal_kadin extends StatelessWidget {
  const normal_kadin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 500,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 25,
            left: 25,
            child: Image.asset(
              'images/img/normal_kadin.png',
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

class kilolu_kadin extends StatelessWidget {
  const kilolu_kadin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 500,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10,
            left: 5,
            child: Image.asset(
              'images/img/kilolu_kadin.png',
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

class obez_kadin extends StatelessWidget {
  const obez_kadin({
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
            left: 5,
            child: Image.asset(
              'images/img/obez_kadin.png',
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

class asiri_obez_kadin extends StatelessWidget {
  const asiri_obez_kadin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 380,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 15,
            left: 10,
            child: Image.asset(
              'images/img/asiri_obez_kadin.png',
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
