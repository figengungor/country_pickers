# country_pickers example

Example project that shows usage of country_pickers library.

![](art/cp.gif)


##### CountryPickerDropdown example

```dart
 CountryPickerDropdown(
            initialValue: 'AR',
            itemBuilder: _buildDropdownItem,
            itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
            priorityList:[
                    CountryPickerUtils.getCountryByIsoCode('GB'),
                    CountryPickerUtils.getCountryByIsoCode('CN'),
                  ],
            sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
            onValuePicked: (Country country) {
              print("${country.name}");
            },
          )
```


```dart
 Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );
```


##### CountryPickerDialog example

```dart
void _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CountryPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your phone code'),
                onValuePicked: (Country country) =>
                    setState(() => _selectedDialogCountry = country),
                itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                priorityList: [
                  CountryPickerUtils.getCountryByIsoCode('TR'),
                  CountryPickerUtils.getCountryByIsoCode('US'),
                 ],
                itemBuilder: _buildDialogItem)),
      );
```



##### CountryPickerCupertino example

```dart
 void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: 300.0,
          onValuePicked: (Country country) =>
              setState(() => _selectedCupertinoCountry = country),
          itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('TR'),
            CountryPickerUtils.getCountryByIsoCode('US'),
          ],
        );
      });
```


## Credits

Thanks goes to [country-flags](https://github.com/hjnilsson/country-flags) repo for the flag image assets.
```