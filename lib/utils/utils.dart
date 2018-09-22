import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:flutter/widgets.dart';

class CountryPickerUtils {
  static Country getCountryByIsoCode(String isoCode) {
    final _countries =
        countriesList.map((item) => Country.fromMap(item)).toList();
    try {
      return _countries
          .where((country) =>
              country.isoCode.toLowerCase() == isoCode.toLowerCase())
          .toList()[0];
    } catch (error) {
      throw Exception("The initialValue provided is not a supported iso code!");
    }
  }

  static String getFlagImageAssetPath(String isoCode) {
    return "assets/${isoCode.toLowerCase()}.png";
  }

  static Widget getDefaultFlagImage(Country country) {
    return Image.asset(
      CountryPickerUtils.getFlagImageAssetPath(country.isoCode),
      height: 20.0,
      width: 30.0,
      fit: BoxFit.fill,
      package: "country_pickers",
    );
  }
}
