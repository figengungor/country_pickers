class Country {
  final String name;
  final String isoCode;
  final String iso3Code;
  final String currencyCode;
  Country({this.isoCode, this.iso3Code, this.currencyCode, this.name});

  factory Country.fromMap(Map<String, String> map) => Country(
        name: map['name'],
        isoCode: map['isoCode'],
        iso3Code: map['iso3Code'],
        phoneCode: map['currencyCode'],
      );
}
