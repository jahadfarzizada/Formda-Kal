class Tuketim {
  final int tuketimMiktar;
  final int tuketimGun;
  Tuketim(this.tuketimMiktar, this.tuketimGun);

  Tuketim.fromMap(Map<String, dynamic> map)
      : assert(map['Tüketilen'] != null),
        assert(map['Gün'] != null),
        tuketimMiktar = map['Tüketilen'],
        tuketimGun = map['Gün'];

  @override
  String toString() => "Record<$tuketimMiktar:$tuketimGun>";
}
