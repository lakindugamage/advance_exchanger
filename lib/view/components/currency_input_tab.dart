import 'package:advance_exchanger/util/convert_util.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:advance_exchanger/view/common/color/custom_colors.dart';
import 'package:advance_exchanger/view_models/currency_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyInputTab extends StatefulWidget {
  final String? selectedValue;
  final double borderRadius;
  final double currencySelectorWidth;

  const CurrencyInputTab({
    super.key,
    this.selectedValue,
    this.borderRadius = 10,
    this.currencySelectorWidth = 125,
  });

  @override
  State<CurrencyInputTab> createState() => _CurrencyInputTabState();
}

class _CurrencyInputTabState extends State<CurrencyInputTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currency = Provider.of<CurrencyStore>(context);

    return SizedBox(
      child: Row(
        children: [
          // Enter the amount which needs to calculate.
          SizedBox(
            width: (MediaQuery.sizeOf(context).width - 40) -
                widget.currencySelectorWidth,
            child: TextFormField(
              initialValue: '0.00',
              onChanged: (value) =>
                  currency.setAmount(double.tryParse(value) ?? 0.00),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: CustomColor.ligthBlack,
                labelStyle: Theme.of(context).textTheme.bodyLarge,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius),
                    bottomLeft: Radius.circular(widget.borderRadius),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Select the currency of the entered amount.
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
                initialValue: currency.baseCountry.isoCode, // 'tr'
                itemBuilder: _buildDropdownItem,
                onValuePicked: (Country? country) {
                  // Update base country and trigger conversion rate update.
                  currency.setCountryCode(country!);
                  // Fetch conversion rates for all target currencies in the list.
                  currency.fetchConversionRates().then((_) {
                    // Once conversion rates are fetched, update all converters.
                    // ignore: unused_local_variable
                    for (String targetCurrency in currency.targetCurrencies) {
                      convertCurrency(
                        country.currencyCode!,
                        currency.conversionRates,
                        currency.amount,
                      );
                    }
                  });
                },
              ),
            ),
          ),
        ],
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
            "${country.currencyCode}", // currencyCode = USD, LKR
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
