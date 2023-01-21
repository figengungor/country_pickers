import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';

/// Returns true when a country should be included in lists / dialogs
/// offered to the user.
typedef ItemFilter = bool Function(Country country);

///Predicate to be satisfied in order to add country to search list
typedef SearchFilter = bool Function(Country country, String searchWord);

typedef ItemBuilder = Widget Function(Country country);

/// Simple closure which always returns true.
bool acceptAllCountries(_) => true;
