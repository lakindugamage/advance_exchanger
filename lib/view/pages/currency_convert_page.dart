import 'package:advance_exchanger/view/common/color/custom_colors.dart';
import 'package:advance_exchanger/view/components/currency_input_tab.dart';
import 'package:advance_exchanger/view/components/currency_output_tab.dart';
import 'package:advance_exchanger/view/components/custom_icon_with_text_button.dart';
import 'package:advance_exchanger/view_models/currency_store.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CurrencyConvertPage extends StatefulWidget {
  const CurrencyConvertPage({super.key});

  @override
  State<CurrencyConvertPage> createState() => _CurrencyConvertPageState();
}

class _CurrencyConvertPageState extends State<CurrencyConvertPage> {
  // List of converters.
  List<String> converters = [];
  
  // Increment number of converters
  void incrementConverters() {
    setState(() {
      converters.add((converters.length + 1).toString());
    });
  }

  @override
  void initState() {
    super.initState();
    // Load preferred currencies on initialization
    final currencyStore = Provider.of<CurrencyStore>(context, listen: false);
    currencyStore.loadPreferredCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    final currency = Provider.of<CurrencyStore>(context);

    // Fetch conversion rates whenever the input currency changes
    currency.fetchConversionRates();

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
                child: ListView.builder(
                  itemCount: currency.targetCurrencies.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currency0 = currency.targetCurrencies[index];
                    return Dismissible(
                      key: Key(currency0),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        // Remove currency from the store.
                        currency.removeTargetCurrency(currency0);
                        // Notify user the currency converter is deleted.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Center(child: Text('Converter Deleted')),
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
                      child: CurrencyOutputTab(targetCurrency: currency0),
                    );
                  },
                ),
              ),
              Center(
                child: CustomIconWithTextButton(
                  onTap: () {
                    // Increment the number of converters.
                    incrementConverters();
                    // Add a new currency to the store.
                    currency.addTargetCurrency('LKR'); 
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
