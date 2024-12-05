import 'package:advance_exchanger/view/common/theme/dark_theme.dart';
import 'package:advance_exchanger/view/common/theme/light_theme.dart';
import 'package:advance_exchanger/view/pages/currency_convert_page.dart';
import 'package:advance_exchanger/view_models/currency_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // Ensure WidgetsBinding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({
    super.key,
    required this.sharedPreferences,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        // Provide CurrencyStore with SharedPreferences
        Provider<CurrencyStore>(
          create: (_) => CurrencyStore(sharedPreferences: sharedPreferences),
        ),
      ],
      child: MaterialApp(
        title: 'Advance Exchanger',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        home: const CurrencyConvertPage(),
      ),
    );
  }
}
