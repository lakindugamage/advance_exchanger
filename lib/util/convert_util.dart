import 'package:mobx/mobx.dart';

String convertCurrency(String currency,  ObservableMap<String, num> conversionRates, double amount) {
    if (conversionRates.containsKey(currency)) {
      num convertedAmount = amount * conversionRates[currency]!;
      return convertedAmount.toStringAsFixed(2);
    } else {
      return '0.00';
    }
  }