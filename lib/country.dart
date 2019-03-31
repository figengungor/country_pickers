class Country {
  Country(this.isoCode, this.iso3Code, this.phoneCode, this.name);
  final String name;
  final String isoCode;
  final String iso3Code;
  final String phoneCode;

  Country.fromMap(Map<String, String> map)
      : name = map['name'],
        isoCode = map['isoCode'],
        iso3Code = map['iso3Code'],
        phoneCode = map['phoneCode'];
}
