import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../domain/domain.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpDataProvider implements IRemoteDataProvider {
  HttpDataProvider({required http.Client client}) : _client = http.Client();
  final http.Client _client;

  @override
  Future<NewsResponse> getNewsByCategory(
      {required String country,
      required int page,
      required String category}) async {
    try {
      final jsonData = await _getJsonData('top-headlines',
          page: page, country: country, category: category);

      return compute(_parseNewsResponse, jsonData);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<NewsResponse> getTopNews({required String country}) async {
    try {
      final jsonData =
          await _getJsonData('top-headlines', country: country, page: 1);

      return compute(_parseNewsResponse, jsonData);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Article>> getSearchNews(
      {required String query,
      required String sortBy,
      required String language}) async {
    try {
      final jsonData = await _getJsonSearchData('everything',
          page: 1,
          query: query,
          language: language,
          sortBy: sortBy,
          pageSize: 20);
      return compute(_parseSearchResponse, jsonData);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _getJsonData(String endpoint,
      {required int page, required String country, String? category}) async {
    try {
      Uri url = Uri.https('newsapi.org', "/v2/$endpoint", {
        'apiKey': dotenv.env['APIKEY'],
        "page": "$page",
        "country": country,
        "category": category
      });
      final response = await _client.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('code: ${response.statusCode}');
    } catch (_) {
      rethrow;
    }
  }

  Future<String> _getJsonSearchData(String endpoint,
      {required int page,
      required String language,
      required String query,
      required String sortBy,
      required int pageSize}) async {
    try {
      Uri url = Uri.https('newsapi.org', "/v2/$endpoint", {
        'apiKey': dotenv.env['APIKEY'],
        "page": page,
        "language": language,
        "q": query,
        "sortBy": sortBy,
        "pageSize": pageSize
      });
      final response = await _client.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }
      throw Exception('code: ${response.statusCode}');
    } catch (_) {
      rethrow;
    }
  }
}

NewsResponse _parseNewsResponse(String responseData) {
  final newsResponse = NewsResponse.fromJson(responseData);
  return newsResponse;
}

List<Article> _parseSearchResponse(String responseData) {
  final newsResponse = NewsResponse.fromJson(responseData);
  return newsResponse.articles;
}
