import 'package:advance_exchanger/models/currency_model.dart';
import 'package:advance_exchanger/services/api_service.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'currency_store.g.dart';

// ignore: library_private_types_in_public_api
class CurrencyStore = _CurrencyStore with _$CurrencyStore;

abstract class _CurrencyStore with Store {
  static const String _targetCurrenciesKey = 'target_currencies';

  final SharedPreferences sharedPreferences;

  _CurrencyStore({required this.sharedPreferences}) {
    loadPreferredCurrencies();
  }

  // The base currency for conversion.
  @observable
  String inputCurrency = 'USD';

  // The country selected for currency conversion (used to determine the base currency).
  @observable
  Country baseCountry = CountryPickerUtils.getCountryByIsoCode('us');

  // The amount that the user wants to convert.
  @observable
  double amount = 0.00;

  // The list of target currencies to convert to.
  @observable
  ObservableList<String> targetCurrencies = ObservableList<String>();

  // A map of conversion rates for each target currency.
  @observable
  ObservableMap<String, num> conversionRates = ObservableMap<String, num>();

  // Sets the input currency (e.g., USD, EUR).
  @action
  void setInputCurrency(String currency) {
    inputCurrency = currency;
  }

  // Sets the amount to be converted.
  @action
  void setAmount(double value) {
    amount = value;
  }
  
  // Adds a target currency to the list of currencies to convert to.
  // It will only add the currency if it's not already in the list.
  @action
  void addTargetCurrency(String currency) {
    if (!targetCurrencies.contains(currency)) {
      targetCurrencies.add(currency);
      _savePreferredCurrencies();
    }
  }
  
  // Removes a target currency from the list and updates conversion rates.
  @action
  void removeTargetCurrency(String currency) {
    targetCurrencies.remove(currency);
    conversionRates.remove(currency);
    _savePreferredCurrencies();
  }
  
  // Sets the country code for the selected base currency.
  @action
  void setCountryCode(Country country) {
    baseCountry = country;
  }

  // Fetches the current conversion rates for the selected base currency.
  @action
  Future<void> fetchConversionRates() async {
    CurrencyModel currencyModel = await ApiService().fetchCurrencyRates(baseCountry.currencyCode!);
    conversionRates = ObservableMap<String, num>.of(currencyModel.rates);
  }

  // Converts the provided amount to the given target currency using the conversion rates.
  // Returns the converted amount as a string formatted to two decimal places.
  @action
  String convertCurrency(String currency) {
    if (conversionRates.containsKey(currency)) {
      num convertedAmount = amount * conversionRates[currency]!;
      return convertedAmount.toStringAsFixed(2);
    } else {
      return '0.00';
    }
  }
  
  // Loads the list of preferred currencies from local storage (SharedPreferences).
  @action
  Future<void> loadPreferredCurrencies() async {
    final savedCurrencies = sharedPreferences.getStringList(_targetCurrenciesKey) ?? [];
    targetCurrencies = ObservableList<String>.of(savedCurrencies);
  }

  // Saves the current list of preferred currencies to local storage (SharedPreferences).
  Future<void> _savePreferredCurrencies() async {
    await sharedPreferences.setStringList(_targetCurrenciesKey, targetCurrencies.toList());
  }
}
