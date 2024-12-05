// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CurrencyStore on _CurrencyStore, Store {
  late final _$inputCurrencyAtom =
      Atom(name: '_CurrencyStore.inputCurrency', context: context);

  @override
  String get inputCurrency {
    _$inputCurrencyAtom.reportRead();
    return super.inputCurrency;
  }

  @override
  set inputCurrency(String value) {
    _$inputCurrencyAtom.reportWrite(value, super.inputCurrency, () {
      super.inputCurrency = value;
    });
  }

  late final _$baseCountryAtom =
      Atom(name: '_CurrencyStore.baseCountry', context: context);

  @override
  Country get baseCountry {
    _$baseCountryAtom.reportRead();
    return super.baseCountry;
  }

  @override
  set baseCountry(Country value) {
    _$baseCountryAtom.reportWrite(value, super.baseCountry, () {
      super.baseCountry = value;
    });
  }

  late final _$amountAtom =
      Atom(name: '_CurrencyStore.amount', context: context);

  @override
  double get amount {
    _$amountAtom.reportRead();
    return super.amount;
  }

  @override
  set amount(double value) {
    _$amountAtom.reportWrite(value, super.amount, () {
      super.amount = value;
    });
  }

  late final _$targetCurrenciesAtom =
      Atom(name: '_CurrencyStore.targetCurrencies', context: context);

  @override
  ObservableList<String> get targetCurrencies {
    _$targetCurrenciesAtom.reportRead();
    return super.targetCurrencies;
  }

  @override
  set targetCurrencies(ObservableList<String> value) {
    _$targetCurrenciesAtom.reportWrite(value, super.targetCurrencies, () {
      super.targetCurrencies = value;
    });
  }

  late final _$conversionRatesAtom =
      Atom(name: '_CurrencyStore.conversionRates', context: context);

  @override
  ObservableMap<String, num> get conversionRates {
    _$conversionRatesAtom.reportRead();
    return super.conversionRates;
  }

  @override
  set conversionRates(ObservableMap<String, num> value) {
    _$conversionRatesAtom.reportWrite(value, super.conversionRates, () {
      super.conversionRates = value;
    });
  }

  late final _$fetchConversionRatesAsyncAction =
      AsyncAction('_CurrencyStore.fetchConversionRates', context: context);

  @override
  Future<void> fetchConversionRates() {
    return _$fetchConversionRatesAsyncAction
        .run(() => super.fetchConversionRates());
  }

  late final _$loadPreferredCurrenciesAsyncAction =
      AsyncAction('_CurrencyStore.loadPreferredCurrencies', context: context);

  @override
  Future<void> loadPreferredCurrencies() {
    return _$loadPreferredCurrenciesAsyncAction
        .run(() => super.loadPreferredCurrencies());
  }

  late final _$_CurrencyStoreActionController =
      ActionController(name: '_CurrencyStore', context: context);

  @override
  void setInputCurrency(String currency) {
    final _$actionInfo = _$_CurrencyStoreActionController.startAction(
        name: '_CurrencyStore.setInputCurrency');
    try {
      return super.setInputCurrency(currency);
    } finally {
      _$_CurrencyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmount(double value) {
    final _$actionInfo = _$_CurrencyStoreActionController.startAction(
        name: '_CurrencyStore.setAmount');
    try {
      return super.setAmount(value);
    } finally {
      _$_CurrencyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTargetCurrency(String currency) {
    final _$actionInfo = _$_CurrencyStoreActionController.startAction(
        name: '_CurrencyStore.addTargetCurrency');
    try {
      return super.addTargetCurrency(currency);
    } finally {
      _$_CurrencyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTargetCurrency(String currency) {
    final _$actionInfo = _$_CurrencyStoreActionController.startAction(
        name: '_CurrencyStore.removeTargetCurrency');
    try {
      return super.removeTargetCurrency(currency);
    } finally {
      _$_CurrencyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCountryCode(Country country) {
    final _$actionInfo = _$_CurrencyStoreActionController.startAction(
        name: '_CurrencyStore.setCountryCode');
    try {
      return super.setCountryCode(country);
    } finally {
      _$_CurrencyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String convertCurrency(String currency) {
    final _$actionInfo = _$_CurrencyStoreActionController.startAction(
        name: '_CurrencyStore.convertCurrency');
    try {
      return super.convertCurrency(currency);
    } finally {
      _$_CurrencyStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inputCurrency: ${inputCurrency},
baseCountry: ${baseCountry},
amount: ${amount},
targetCurrencies: ${targetCurrencies},
conversionRates: ${conversionRates}
    ''';
  }
}
