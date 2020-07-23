# country_currency_pickers

Countries, codes, flags, currency and several way of picking them at your service...one widget away...

![](art/cp.gif)


##### CountryPickerDropdown example

```dart
 CountryPickerDropdown(
            initialValue: 'tr',
            itemBuilder: _buildDropdownItem,
            onValuePicked: (Country country) {
              print("${country.name}");
            },
          ),
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

##### CurrencyPickerDropdown example

```dart
 CurrencyPickerDropdown(
            initialValue: 'INR',
            itemBuilder: _buildCurrencyDropdownItem,
            onValuePicked: (Country country) {
              print("${country.name}");
            },
          ),
```

```dart
 Widget _buildCurrencyDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("${country.currencyCode}"),
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
                itemBuilder: _buildDialogItem)),
      );
```

##### CurrencyPickerDialog example

```dart
void _openCurrencyPickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: CurrencyPickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration: InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text('Select your Currency'),
                onValuePicked: (Country country) =>
                    setState(() => _selectedDialogCountry = country),
                itemBuilder: _buildCurrencyDialogItem)),
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
        );
      });
```

##### CurrencyPickerCupertino example

```dart
 void _openCupertinoCurrencyPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CurrencyPickerCupertino(
          pickerSheetHeight: 300.0,
          onValuePicked: (Country country) =>
              setState(() => _selectedCupertinoCountry = country),
        );
      });
```

## Credits

Forked from [country_pickers](https://github.com/figengungor/country_pickers) repo.
Thanks goes to [country-flags](https://github.com/hjnilsson/country-flags) repo for the flag image assets.
[Learn Pain Less | Code Academy (learn to code)](https://learnpainless.com)
