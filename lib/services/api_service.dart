import 'package:advance_exchanger/models/currency_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio _dio = Dio();

  // Fetches currency conversion rates from the API.
  Future<CurrencyModel> fetchCurrencyRates(String baseCurrency) async {
    final baseUrl = dotenv.env['API_BASE_URL']!;

    try {
      final response = await _dio.get("$baseUrl$baseCurrency");

      if (response.statusCode == 200) {
        return CurrencyModel.fromJson(response.data);
      } else {
        throw Exception("Failed to fetch data: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching currency rates: $error");
    }
  }
}
