class CurrencyModel {
  final String baseCurrency;
  final Map<String, num> rates;

  CurrencyModel({
    required this.baseCurrency,
    required this.rates,
  });

  // Factory constructor to create an instance from JSON data.
  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      baseCurrency: json['base'] as String,
      rates: Map<String, num>.from(json['rates'] as Map),
    );
  }

  // Converts the CurrencyModel instance back to JSON.
  Map<String, dynamic> toJson() {
    return {
      'base': baseCurrency,
      'rates': rates,
    };
  }
}