import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:advance_exchanger/view/common/color/custom_colors.dart';
import 'package:advance_exchanger/view_models/currency_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class CurrencyOutputTab extends StatefulWidget {
  final String targetCurrency;
  final double borderRadius;
  final double currencySelectorWidth;

  const CurrencyOutputTab({
    super.key,
    required this.targetCurrency,
    this.borderRadius = 10,
    this.currencySelectorWidth = 125,
  });

  @override
  State<CurrencyOutputTab> createState() => _CurrencyOutputTabState();
}

class _CurrencyOutputTabState extends State<CurrencyOutputTab> {
  late Country selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = CountryPickerUtils.getCountryByIsoCode(
      CountryPickerUtils.getCountryByCurrencyCode(widget.targetCurrency)
              .isoCode ??
          'us',
    );
  }

  @override
  Widget build(BuildContext context) {
    final _currency = Provider.of<CurrencyStore>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        child: Row(
          children: [
            // Converted currency display section.
            SizedBox(
              width: (MediaQuery.sizeOf(context).width - 40) -
                  widget.currencySelectorWidth,
              height: 56,
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColor.ligthBlack,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius),
                    bottomLeft: Radius.circular(widget.borderRadius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 18, left: 12),
                  child: Observer(
                    builder: (_) {
                      // Display the converted value.
                      final convertedValue =
                          _currency.convertCurrency(widget.targetCurrency);
                      return Text(
                        convertedValue,
                        style: Theme.of(context).textTheme.bodyLarge,
                      );
                    },
                  ),
                ),
              ),
            ),
            // Select the currency to convert.
            Container(
              width: widget.currencySelectorWidth,
              height: 56,
              padding: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: CustomColor.ligthBlack,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(widget.borderRadius),
                  bottomRight: Radius.circular(widget.borderRadius),
                ),
              ),
              child: Center(
                child: CountryPickerDropdown(
                  initialValue: selectedCountry.isoCode?.toLowerCase(),
                  itemBuilder: _buildDropdownItem,
                  onValuePicked: (Country? country) {
                    setState(() {
                      selectedCountry = country!;
                      _currency
                          .addTargetCurrency(selectedCountry.currencyCode!);
                      _currency.setCountryCode(country);
                      _currency.fetchConversionRates();
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDropdownItem(Country country) => SizedBox(
      child: Row(
        children: <Widget>[
          ClipOval(
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: CountryPickerUtils.getDefaultFlagImage(country),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            "${country.currencyCode}",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
