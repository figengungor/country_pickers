# currency_pickers

Currency picker for flutter


##### CurrencyPickerDropdown example

```dart
 CurrencyPickerDropdown(
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
            CurrencyPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.currencyCode}(${country.isoCode})"),
          ],
        ),
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
                title: Text('Select your phone code'),
                onValuePicked: (Country country) =>
                    setState(() => _selectedDialogCountry = country),
                itemBuilder: _buildDialogItem)),
      );
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
