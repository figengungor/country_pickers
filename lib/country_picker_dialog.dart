import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/typedefs.dart';
import 'package:country_pickers/utils/my_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'countries.dart';

///Provides a customizable [Dialog] which displays all countries
/// with optional search feature

class CountryPickerDialog extends StatefulWidget {
  /// Callback that is called with selected Country
  final ValueChanged<Country> onValuePicked;

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided. Otherwise, this padding
  /// is used.
  ///
  /// This property defaults to providing 12 pixels on the top,
  /// 16 pixels on bottom of the title. If the [content] is not null, then no bottom padding is
  /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
  /// pixels of bottom padding is added to separate the [title] from the
  /// [actions].
  final EdgeInsetsGeometry? titlePadding;

  /// Padding around the content.

  final EdgeInsetsGeometry contentPadding;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  ///
  /// If this label is not provided, a semantic label will be infered from the
  /// [title] if it is not null.  If there is no title, the label will be taken
  /// from [MaterialLocalizations.alertDialogLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.isRouteName], for a description of how this
  ///    value is used.
  final String? semanticLabel;

  /// Filters the available country list
  final ItemFilter? itemFilter;

  /// [Comparator] to be used in sort of country list
  final Comparator<Country>? sortComparator;

  /// List of countries that are placed on top
  final List<Country>? priorityList;

  ///Callback that is called with selected item of type Country which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder? itemBuilder;

  /// The (optional) horizontal separator used between title, content and
  /// actions.
  ///
  /// If this divider is not provided a [Divider] is used with [height]
  /// property is set to 0.0
  final Widget divider;

  /// The [divider] is not displayed if set to false. Default is set to false.
  final bool isDividerEnabled;

  /// Determines if search [TextField] is shown or not
  /// Defaults to false
  final bool isSearchable;

  /// The optional [decoration] of search [TextField]
  final InputDecoration? searchInputDecoration;

  ///The optional [cursorColor] of search [TextField]
  final Color? searchCursorColor;

  ///The search empty view is displayed if nothing returns from search result
  final Widget? searchEmptyView;

  ///By default the dialog will be popped of the navigator on selection of a value.
  ///Set popOnPick to false to prevent this behaviour.
  final bool popOnPick;

  ///Filters the country list for search
  final SearchFilter? searchFilter;

  const CountryPickerDialog({
    super.key,
    required this.onValuePicked,
    this.title,
    this.titlePadding,
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
    this.semanticLabel,
    this.itemFilter,
    this.sortComparator,
    this.priorityList,
    this.itemBuilder,
    this.isDividerEnabled = false,
    this.divider = const Divider(
      height: 0.0,
    ),
    this.isSearchable = false,
    this.popOnPick = true,
    this.searchInputDecoration,
    this.searchCursorColor,
    this.searchEmptyView,
    this.searchFilter,
  });

  @override
  SingleChoiceDialogState createState() {
    return SingleChoiceDialogState();
  }
}

class SingleChoiceDialogState extends State<CountryPickerDialog> {
  late List<Country> _allCountries;

  late List<Country> _filteredCountries;

  @override
  void initState() {
    _allCountries =
        countryList.where(widget.itemFilter ?? acceptAllCountries).toList();

    if (widget.sortComparator != null) {
      _allCountries.sort(widget.sortComparator);
    }

    if (widget.priorityList != null) {
      for (var country in widget.priorityList!) {
        _allCountries
          .removeWhere((Country c) => country.isoCode == c.isoCode);
      }
      _allCountries.insertAll(0, widget.priorityList!);
    }

    _filteredCountries = _allCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAlertDialog(
      title: _buildHeader(),
      contentPadding: widget.contentPadding,
      semanticLabel: widget.semanticLabel,
      content: _buildContent(context),
      isDividerEnabled: widget.isDividerEnabled,
      divider: widget.divider,
    );
  }

  _buildContent(BuildContext context) {
    return _filteredCountries.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            children: _filteredCountries
                .map((item) => SimpleDialogOption(
                      child: widget.itemBuilder != null
                          ? widget.itemBuilder!(item)
                          : Text(item.name),
                      onPressed: () {
                        widget.onValuePicked(item);
                        if (widget.popOnPick) {
                          Navigator.pop(context);
                        }
                      },
                    ))
                .toList(),
          )
        : widget.searchEmptyView ??
            const Center(
              child: Text('No country found.'),
            );
  }

  _buildHeader() {
    return widget.isSearchable
        ? Column(
            children: <Widget>[
              _buildTitle(),
              _buildSearchField(),
            ],
          )
        : _buildTitle();
  }

  _buildTitle() {
    return widget.titlePadding != null
        ? Padding(
            padding: widget.titlePadding!,
            child: widget.title,
          )
        : widget.title;
  }

  _buildSearchField() {
    return TextField(
      cursorColor: widget.searchCursorColor,
      decoration:
          widget.searchInputDecoration ?? const InputDecoration(hintText: 'Search'),
      onChanged: (String value) {
        setState(() {
          _filteredCountries = _allCountries
              .where((Country country) => widget.searchFilter == null
                  ? country.name.toLowerCase().contains(value.toLowerCase()) ||
                      country.phoneCode.startsWith(value.toLowerCase()) ||
                      country.isoCode
                          .toLowerCase()
                          .startsWith(value.toLowerCase()) ||
                      country.iso3Code
                          .toLowerCase()
                          .startsWith(value.toLowerCase())
                  : widget.searchFilter!(country, value))
              .toList();
        });
      },
    );
  }
}
