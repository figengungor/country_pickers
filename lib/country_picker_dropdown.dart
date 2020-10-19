import 'package:country_pickers/country.dart';
import 'package:country_pickers/countries.dart';
import 'package:country_pickers/utils/typedefs.dart';
import 'package:flutter/material.dart';
import 'utils/utils.dart';

///Provides a customizable [DropdownButton] for all countries
class CountryPickerDropdown extends StatefulWidget {
  CountryPickerDropdown({
    this.itemFilter,
    this.sortComparator,
    this.priorityList,
    this.countryList,
    this.itemBuilder,
    this.initialValue,
    this.onValuePicked,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.selectedItemBuilder,
    this.isDense = false,
    this.underline,
    this.dropdownColor,
    this.onTap,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.hint,
    this.disabledHint,
    this.isFirstDefaultIfInitialValueNotProvided = true,
  });

  /// Filters the available country list
  final ItemFilter itemFilter;

  /// [Comparator] to be used in sort of country list
  final Comparator<Country> sortComparator;

  /// List of countries that are placed on top
  final List<Country> priorityList;

  /// List of countries
  final List<Country> countryList;

  ///This function will be called to build the child of DropdownMenuItem
  ///If it is not provided, default one will be used which displays
  ///flag image, isoCode and phoneCode in a row.
  ///Check _buildDefaultMenuItem method for details.
  final ItemBuilder itemBuilder;

  ///It should be one of the ISO ALPHA-2 Code that is provided
  ///in countryList map of countries.dart file.
  final String initialValue;

  ///This function will be called whenever a Country item is selected.
  final ValueChanged<Country> onValuePicked;

  /// Boolean property to enabled/disable expanded property of DropdownButton
  final bool isExpanded;

  /// See [itemHeight] of [DropdownButton]
  final double itemHeight;

  /// See [isDense] of [DropdownButton]
  final bool isDense;

  /// See [underline] of [DropdownButton]
  final Widget underline;

  /// Selected country widget builder to display. See [selectedItemBuilder] of [DropdownButton]
  final ItemBuilder selectedItemBuilder;

  /// See [dropdownColor] of [DropdownButton]
  final Color dropdownColor;

  /// See [onTap] of [DropdownButton]
  final VoidCallback onTap;

  /// See [icon] of [DropdownButton]
  final Widget icon;

  /// See [iconDisabledColor] of [DropdownButton]
  final Color iconDisabledColor;

  /// See [iconEnabledColor] of [DropdownButton]
  final Color iconEnabledColor;

  /// See [iconSize] of [DropdownButton]
  final double iconSize;

  /// See [hint] of [DropdownButton]
  final Widget hint;

  /// See [disabledHint] of [DropdownButton]
  final Widget disabledHint;

  /// Set first item in the country list as selected initially
  /// if initialValue is not provided
  final bool isFirstDefaultIfInitialValueNotProvided;

  @override
  _CountryPickerDropdownState createState() => _CountryPickerDropdownState();
}

class _CountryPickerDropdownState extends State<CountryPickerDropdown> {
  List<Country> _countries;
  Country _selectedCountry;

  @override
  void initState() {
    final _countryList = widget.countryList ?? countryList;
    _countries =
        _countryList.where(widget.itemFilter ?? acceptAllCountries).toList();

    if (widget.sortComparator != null) {
      _countries.sort(widget.sortComparator);
    }

    if (widget.priorityList != null) {
      widget.priorityList.forEach((Country country) =>
          _countries.removeWhere((Country c) => country.isoCode == c.isoCode));
      _countries.insertAll(0, widget.priorityList);
    }

    if (widget.initialValue != null) {
      try {
        _selectedCountry = _countries.firstWhere(
          (country) => country.isoCode == widget.initialValue.toUpperCase(),
        );
      } catch (error) {
        throw Exception(
            "The initialValue provided is not a supported iso code!");
      }
    } else {
      if (widget.isFirstDefaultIfInitialValueNotProvided &&
          _countries.length > 0) {
        _selectedCountry = _countries[0];
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Country>> items = _countries
        .map((country) => DropdownMenuItem<Country>(
            value: country,
            child: widget.itemBuilder != null
                ? widget.itemBuilder(country)
                : _buildDefaultMenuItem(country)))
        .toList();

    return DropdownButton<Country>(
      hint: widget.hint,
      disabledHint: widget.disabledHint,
      onTap: widget.onTap,
      icon: widget.icon,
      iconSize: widget.iconSize,
      iconDisabledColor: widget.iconDisabledColor,
      iconEnabledColor: widget.iconEnabledColor,
      dropdownColor: widget.dropdownColor,
      underline: widget.underline ?? SizedBox(),
      isDense: widget.isDense,
      isExpanded: widget.isExpanded,
      onChanged: (value) {
        setState(() {
          _selectedCountry = value;
          widget.onValuePicked(value);
        });
      },
      items: items,
      value: _selectedCountry,
      itemHeight: widget.itemHeight,
      selectedItemBuilder: widget.selectedItemBuilder != null
          ? (context) {
              return _countries
                  .map((c) => widget.selectedItemBuilder(c))
                  .toList();
            }
          : null,
    );
  }

  Widget _buildDefaultMenuItem(Country country) {
    return Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(
          width: 8.0,
        ),
        Text("(${country.isoCode}) +${country.phoneCode}"),
      ],
    );
  }
}
