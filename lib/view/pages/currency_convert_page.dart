import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:advance_exchanger/view/common/color/custom_colors.dart';
import 'package:advance_exchanger/view/components/currency_input_tab.dart';
import 'package:advance_exchanger/view/components/currency_output_tab.dart';
import 'package:advance_exchanger/view/components/custom_icon_with_text_button.dart';
import 'package:advance_exchanger/view_models/currency_store.dart';

class CurrencyConvertPage extends StatefulWidget {
  const CurrencyConvertPage({super.key});

  @override
  State<CurrencyConvertPage> createState() => _CurrencyConvertPageState();
}

class _CurrencyConvertPageState extends State<CurrencyConvertPage> {
  @override
  void initState() {
    super.initState();
    final currencyStore = Provider.of<CurrencyStore>(context, listen: false);
    currencyStore.loadPreferredCurrencies();
    currencyStore.fetchConversionRates();
  }

  @override
  Widget build(BuildContext context) {
    final currency = Provider.of<CurrencyStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advanced Exchanger',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  'INSERT AMOUNT :',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const CurrencyInputTab(),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  'CONVERT TO :',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: Observer(
                  builder: (_) => RefreshIndicator(
                    onRefresh: () async {
                      // Fetch conversion rates and refresh the list
                      await currency.fetchConversionRates();
                    },
                    child: ListView.builder(
                      itemCount: currency.targetCurrencies.length,
                      itemBuilder: (BuildContext context, int index) {
                        final currency0 = currency.targetCurrencies[index];
                        return Dismissible(
                          key: Key(currency0),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            currency.removeTargetCurrency(currency0);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Center(
                                  child: Text('Converter Deleted'),
                                ),
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              FontAwesomeIcons.trash,
                              color: Colors.white,
                            ),
                          ),
                          child: CurrencyOutputTab(
                            targetCurrency: currency0,
                            targetCurrencyIndex: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: CustomIconWithTextButton(
                  onTap: () {
                    currency.addTargetCurrency(currency.inputCurrency);
                  },
                  text: 'Add Converter',
                  icon: FontAwesomeIcons.plus,
                  bgColor: CustomColor.green,
                  textColor: CustomColor.lightGreen,
                  iconColor: CustomColor.lightGreen,
                  width: 220,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
