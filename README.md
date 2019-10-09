# country_pickers

Countries, codes, flags and several way of picking them at your service...one widget away...

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

##### Choose your preferred language
you can change the language to (Arabic, Spanish, French and Germany) if you followed those instructions in [countries.dart](./lib/countries.dart)

```dart
final List <Country> countryList = 
new List<Country>.generate(255, (i) => Country(
    isoCode: isoCodeArr[i],
    phoneCode: phoneCodeArr[i],
    name: countryListEN[i],
    // If you want the Arabic Version: change countryListEN to countryListAR
    // If you want the French Version: change countryListEN to countryListFR
    // If you want the German Version: change countryListEN to countryListDR
    // If you want the Spanish Version: change countryListEN to countryListSP
    iso3Code: iso3CodeArr[i],
));
```


## Credits

Thanks goes to [country-flags](https://github.com/hjnilsson/country-flags) repo for the flag image assets.

