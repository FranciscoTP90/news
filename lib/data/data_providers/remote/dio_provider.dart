import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../domain/domain.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioDataProvider implements IRemoteDataProvider {
  DioDataProvider({required Dio client})
      : _client = Dio(BaseOptions(
            baseUrl: 'https://newsapi.org/v2/',
            queryParameters: {'apiKey': dotenv.env['APIKEY']}));

  final Dio _client;

  @override
  Future<NewsResponse> getNewsByCategory(
      {required String country,
      required int page,
      required String category}) async {
    try {
      final response = await _client.get<Map<String, dynamic>>('top-headlines',
          queryParameters: {
            'page': page,
            'category': category,
            'country': country
          });
      if (response.statusCode == 200 && response.data != null) {
        return compute(_parseNewsResponse, response.data!);
      }
      throw Exception(
          'code: ${response.statusCode}, msg: ${response.statusMessage}');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<NewsResponse> getTopNews({required String country}) async {
    try {
      final response = await _client.get<Map<String, dynamic>>('top-headlines',
          queryParameters: {'page': 1, 'country': country});

      if (response.statusCode == 200 && response.data != null) {
        return compute(_parseNewsResponse, response.data!);
      }
      throw Exception(
          'code: ${response.statusCode}, msg: ${response.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Article>> getSearchNews(
      {required String query,
      required String sortBy,
      required String language}) async {
    try {
      log("$query - $language");
      final response = await _client.get<Map<String, dynamic>>('everything',
          queryParameters: {
            'sortBy': sortBy,
            'q': query,
            'page': 1,
            'pageSize': 20,
            'language': language
          });
      if (response.statusCode == 200 && response.data != null) {
        return compute(_parseSearchResponse, response.data!);
      }
      throw Exception(
          'code: ${response.statusCode}, msg: ${response.statusMessage}');
    } catch (e) {
      rethrow;
    }
  }
}

NewsResponse _parseNewsResponse(Map<String, dynamic> responseData) {
  final newsResponse = NewsResponse.fromMap(responseData);
  return newsResponse;
}

List<Article> _parseSearchResponse(Map<String, dynamic> responseData) {
  final newsResponse = NewsResponse.fromMap(responseData);
  return newsResponse.articles;
}
