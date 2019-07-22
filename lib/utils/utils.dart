import 'package:currency_pickers/countries.dart';
import 'package:currency_pickers/country.dart';
import 'package:flutter/widgets.dart';

class CurrencyPickerUtils {
  static Country getCountryByIsoCode(String isoCode) {
    try {
      return countryList.firstWhere(
        (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception("The initialValue provided is not a supported iso code!");
    }
  }

  static String getFlagImageAssetPath(String isoCode) {
    return "assets/${isoCode.toLowerCase()}.png";
  }

  static Widget getDefaultFlagImage(Country country) {
    return Image.asset(
      CurrencyPickerUtils.getFlagImageAssetPath(country.isoCode),
      height: 20.0,
      width: 30.0,
      fit: BoxFit.fill,
      package: "currency_pickers",
    );
  }

  static Country getCountryByCurrencyCode(String currencyCode) {
    try {
      return countryList.firstWhere(
        (country) => country.currencyCode.toLowerCase() == currencyCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception(
          "The initialValue provided is not a supported country code!");
    }
  }
}
