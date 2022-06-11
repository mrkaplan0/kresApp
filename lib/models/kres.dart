class Kres {
  String kresCode;
  String kresAdi;

  Kres(this.kresCode, this.kresAdi);

  Map<String, dynamic> toMap() {
    return {
      'kresCode': kresCode,
      'kresAdi': kresAdi,
    };
  }

  Kres.fromMap(Map<String, dynamic> map)
      : kresCode = map['kresCode'],
        kresAdi = map['kresAdi'];
}
