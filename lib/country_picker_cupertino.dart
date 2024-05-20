import 'package:country_pickers/countries.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/typedefs.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'dart:core';

const double defaultPickerSheetHeight = 216.0;
const double defaultPickerItemHeight = 32.0;

/// Color of picker background
const Color _kDefaultBackground = Color(0xFFD2D4DB);

// Eyeballed values comparing with a native picker.
// Values closer to PI produces denser flatter lists.
const double _kDefaultDiameterRatio = 1.35;

///Provides a customizable [CupertinoPicker] which displays all countries
/// in cupertino style
class CountryPickerCupertino extends StatefulWidget {
  /// Callback that is called with selected Country
  final ValueChanged<Country> onValuePicked;

  /// Filters the available country list
  final ItemFilter? itemFilter;

  /// [Comparator] to be used in sort of country list
  final Comparator<Country>? sortComparator;

  /// List of countries that are placed on top
  final List<Country>? priorityList;

  ///Callback that is called with selected item of type Country which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder? itemBuilder;

  ///The [itemExtent] of [CupertinoPicker]
  /// The uniform height of all children.
  ///
  /// All children will be given the [BoxConstraints] to match this exact
  /// height. Must not be null and must be positive.
  final double pickerItemHeight;

  ///The height of the picker
  final double pickerSheetHeight;

  ///The TextStyle that is applied to Text widgets inside item
  final TextStyle? textStyle;

  /// Relative ratio between this picker's height and the simulated cylinder's diameter.
  ///
  /// Smaller values creates more pronounced curvatures in the scrollable wheel.
  ///
  /// For more details, see [ListWheelScrollView.diameterRatio].
  ///
  /// Must not be null and defaults to `1.1` to visually mimic iOS.
  final double diameterRatio;

  /// Background color behind the children.
  ///
  /// Defaults to a gray color in the iOS color palette.
  ///
  /// This can be set to null to disable the background painting entirely; this
  /// is mildly more efficient than using [Colors.transparent].
  final Color backgroundColor;

  /// {@macro flutter.rendering.wheelList.offAxisFraction}
  final double offAxisFraction;

  /// {@macro flutter.rendering.wheelList.useMagnifier}
  final bool useMagnifier;

  /// {@macro flutter.rendering.wheelList.magnification}
  final double magnification;

  final Country? initialCountry;

  /// A [FixedExtentScrollController] to read and control the current item.
  ///
  /// If null, an implicit one will be created internally.
  final FixedExtentScrollController? scrollController;

  const CountryPickerCupertino({
    super.key,
    required this.onValuePicked,
    this.itemBuilder,
    this.itemFilter,
    this.sortComparator,
    this.priorityList,
    this.pickerItemHeight = defaultPickerItemHeight,
    this.pickerSheetHeight = defaultPickerSheetHeight,
    this.textStyle,
    this.diameterRatio = _kDefaultDiameterRatio,
    this.backgroundColor = _kDefaultBackground,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.scrollController,
    this.initialCountry,
  });

  @override
  State<CountryPickerCupertino> createState() => _CupertinoCountryPickerState();
}

class _CupertinoCountryPickerState extends State<CountryPickerCupertino> {
  late List<Country> _countries;
  FixedExtentScrollController? _scrollController;

  @override
  void initState() {
    super.initState();

    _countries =
        countryList.where(widget.itemFilter ?? acceptAllCountries).toList();

    if (widget.sortComparator != null) {
      _countries.sort(widget.sortComparator);
    }

    if (widget.priorityList != null) {
      for (var country in widget.priorityList!) {
        _countries.removeWhere((Country c) => country.isoCode == c.isoCode);
      }
      _countries.insertAll(0, widget.priorityList!);
    }

    _scrollController = widget.scrollController;

    if ((_scrollController == null) && (widget.initialCountry != null)) {
      var countryInList = _countries
          .where((c) => c.phoneCode == widget.initialCountry!.phoneCode)
          .first;
      _scrollController = FixedExtentScrollController(
          initialItem: _countries.indexOf(countryInList));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBottomPicker(_buildPicker(), context);
  }

  Widget _buildBottomPicker(Widget picker, BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.only(bottom: mediaQueryData.padding.bottom),
      height: widget.pickerSheetHeight + mediaQueryData.padding.bottom,
      child: DefaultTextStyle(
        style: widget.textStyle ??
            const TextStyle(
              color: CupertinoColors.black,
              fontSize: 16.0,
            ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: picker,
        ),
      ),
    );
  }

  Widget _buildPicker() {
    return CupertinoPicker(
      scrollController: _scrollController,
      itemExtent: widget.pickerItemHeight,
      diameterRatio: widget.diameterRatio,
      backgroundColor: widget.backgroundColor,
      offAxisFraction: widget.offAxisFraction,
      useMagnifier: widget.useMagnifier,
      magnification: widget.magnification,
      children: _countries
          .map<Widget>((Country country) => widget.itemBuilder != null
              ? widget.itemBuilder!(country)
              : _buildDefaultItem(country))
          .toList(),
      onSelectedItemChanged: (int index) {
        widget.onValuePicked(_countries[index]);
      },
    );
  }

  _buildDefaultItem(Country country) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      ),
    );
  }
}
