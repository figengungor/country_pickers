class Country {
  final String name;
  final String isoCode;
  final String iso3Code;
  final String currencyCode;
  final String currencyName;
  Country({this.isoCode, this.iso3Code, this.currencyCode, this.currencyName, this.name});

  factory Country.fromMap(Map<String, String> map) => Country(
        name: map['name'],
        isoCode: map['isoCode'],
        iso3Code: map['iso3Code'],
        currencyCode: map['currencyCode'],
        currencyName: map['currencyName'],
      );
}
