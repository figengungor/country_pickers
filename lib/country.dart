class Country {
  final String name;
  final String isoCode;
  final String iso3Code;
  final String phoneCode;
  final String flagEmoji;
  Country({this.isoCode, this.iso3Code, this.phoneCode, this.name,this.flagEmoji});

  factory Country.fromMap(Map<String, String> map) => Country(
        name: map['name'],
        isoCode: map['isoCode'],
        iso3Code: map['iso3Code'],
        phoneCode: map['phoneCode'],
        flagEmoji: map['emoji']
      );
}
