import 'package:country_pickers/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country_pickers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Pickers Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Country _selectedDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('90');

  Country _selectedFilteredDialogCountry =
      CountryPickerUtils.getCountryByPhoneCode('90');

  Country _selectedCupertinoCountry =
      CountryPickerUtils.getCountryByIsoCode('tr');

  Country _selectedFilteredCupertinoCountry =
      CountryPickerUtils.getCountryByIsoCode('DE');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Pickers Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('CountryPickerDropdown (SOLO)'),
                _buildCountryPickerDropdownSoloExpanded(),
                //ListTile(title: _buildCountryPickerDropdown(longerText: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('CountryPickerDropdown (selectedItemBuilder)'),
                _buildCountryPickerDropdown(hasSelectedItemBuilder: true),
                //ListTile(title: _buildCountryPickerDropdown(longerText: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('CountryPickerDropdown (filtered)'),
                ListTile(title: _buildCountryPickerDropdown(filtered: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('CountryPickerDropdown (sorted by isoCode)'),
                ListTile(
                    title: _buildCountryPickerDropdown(sortedByIsoCode: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                    "CountryPickerDropdown (has priorityList['GB,'CN'])"),
                ListTile(
                    title: _buildCountryPickerDropdown(hasPriorityList: true)),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("CountryPickerDialog (has priorityList['TR,'US'])"),
                ListTile(
                  onTap: _openCountryPickerDialog,
                  title: _buildDialogItem(_selectedDialogCountry),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('CountryPickerDialog (filtered)'),
                ListTile(
                  onTap: _openFilteredCountryPickerDialog,
                  title: _buildDialogItem(_selectedFilteredDialogCountry),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                    "CountryPickerCupertino (has priorityList['TR,'US'])"),
                ListTile(
                  title: _buildCupertinoSelectedItem(_selectedCupertinoCountry),
                  onTap: _openCupertinoCountryPicker,
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('CountryPickerCupertino (filtered)'),
                ListTile(
                  title: _buildCupertinoSelectedItem(
                      _selectedFilteredCupertinoCountry),
                  onTap: _openFilteredCupertinoCountryPicker,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildCountryPickerDropdownSoloExpanded() {
    return CountryPickerDropdown(
      underline: Container(
        height: 2,
        color: Colors.red,
      ),
      //show'em (the text fields) you're in charge now
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      //if you want your dropdown button's selected item UI to be different
      //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
      onValuePicked: (Country country) {
        debugPrint("$country.name");
      },
      itemBuilder: (Country country) {
        return Row(
          children: <Widget>[
            const SizedBox(width: 8.0),
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(width: 8.0),
            Expanded(child: Text(country.name)),
          ],
        );
      },
      itemHeight: null,
      isExpanded: true,
      //initialValue: 'TR',
      icon: const Icon(Icons.arrow_downward),
    );
  }

  _buildCountryPickerDropdown(
      {bool filtered = false,
      bool sortedByIsoCode = false,
      bool hasPriorityList = false,
      bool hasSelectedItemBuilder = false}) {
    double dropdownButtonWidth = MediaQuery.of(context).size.width * 0.5;
    //respect dropdown button icon size
    double dropdownItemWidth = dropdownButtonWidth - 30;
    double dropdownSelectedItemWidth = dropdownButtonWidth - 30;
    return Row(
      children: <Widget>[
        SizedBox(
          width: dropdownButtonWidth,
          child: CountryPickerDropdown(
            /* underline: Container(
              height: 2,
              color: Colors.red,
            ),*/
            //show'em (the text fields) you're in charge now
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            //if you have menu items of varying size, itemHeight being null respects
            //that, IntrinsicHeight under the hood ;).
            itemHeight: null,
            //itemHeight being null and isDense being true doesn't play along
            //well together. One is trying to limit size and other is saying
            //limit is the sky, therefore conflicts.
            //false is default but still keep that in mind.
            isDense: false,
            //if you want your dropdown button's selected item UI to be different
            //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
            selectedItemBuilder: hasSelectedItemBuilder == true
                ? (Country country) => _buildDropdownSelectedItemBuilder(
                    country, dropdownSelectedItemWidth)
                : null,
            //initialValue: 'AR',
            itemBuilder: (Country country) => hasSelectedItemBuilder == true
                ? _buildDropdownItemWithLongText(country, dropdownItemWidth)
                : _buildDropdownItem(country, dropdownItemWidth),
            initialValue: 'AR',
            itemFilter: filtered
                ? (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode)
                : null,
            //priorityList is shown at the beginning of list
            priorityList: hasPriorityList
                ? [
                    CountryPickerUtils.getCountryByIsoCode('GB'),
                    CountryPickerUtils.getCountryByIsoCode('CN'),
                  ]
                : null,
            sortComparator: sortedByIsoCode
                ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
                : null,
            onValuePicked: (Country country) {
              debugPrint(country.name);
            },
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: "Phone",
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            keyboardType: TextInputType.number,
          ),
        )
      ],
    );
  }

  Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(child: Text("+${country.phoneCode}(${country.isoCode})")),
          ],
        ),
      );

  Widget _buildDropdownItemWithLongText(
          Country country, double dropdownItemWidth) =>
      SizedBox(
        width: dropdownItemWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(country),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(child: Text(country.name)),
            ],
          ),
        ),
      );

  Widget _buildDropdownSelectedItemBuilder(
          Country country, double dropdownItemWidth) =>
      SizedBox(
          width: dropdownItemWidth,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  CountryPickerUtils.getDefaultFlagImage(country),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                      child: Text(
                    country.name,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )),
                ],
              )));

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your phone code'),
            onValuePicked: (Country country) =>
                setState(() => _selectedDialogCountry = country),
            itemBuilder: _buildDialogItem,
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('TR'),
              CountryPickerUtils.getCountryByIsoCode('US'),
            ],
          ),
        ),
      );

  void _openFilteredCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CountryPickerDialog(
                titlePadding: const EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration:
                    const InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: const Text('Select your phone code'),
                onValuePicked: (Country country) =>
                    setState(() => _selectedFilteredDialogCountry = country),
                itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                itemBuilder: _buildDialogItem)),
      );

  void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          backgroundColor: Colors.black,
          itemBuilder: _buildCupertinoItem,
          pickerSheetHeight: 300.0,
          pickerItemHeight: 75,
          initialCountry: _selectedCupertinoCountry,
          onValuePicked: (Country country) =>
              setState(() => _selectedCupertinoCountry = country),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('TR'),
            CountryPickerUtils.getCountryByIsoCode('US'),
          ],
        );
      });

  void _openFilteredCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          backgroundColor: Colors.white,
          pickerSheetHeight: 200.0,
          initialCountry: _selectedFilteredCupertinoCountry,
          onValuePicked: (Country country) =>
              setState(() => _selectedFilteredCupertinoCountry = country),
          itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
        );
      });

  Widget _buildCupertinoSelectedItem(Country country) {
    return Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(width: 8.0),
        Text("+${country.phoneCode}"),
        const SizedBox(width: 8.0),
        Flexible(child: Text(country.name))
      ],
    );
  }

  Widget _buildCupertinoItem(Country country) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.white,
        fontSize: 16.0,
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8.0),
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Text("+${country.phoneCode}"),
          const SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      ),
    );
  }
}
