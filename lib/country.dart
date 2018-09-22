class Country {
  Country(this.isoCode, this.phoneCode, this.name);
  final String name;
  final String isoCode;
  final String phoneCode;

  Country.fromMap(Map<String, String> map)
      : name = map['name'],
        isoCode = map['isoCode'],
        phoneCode = map['phoneCode'];
}
