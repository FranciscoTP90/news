import '../models/news_response.dart';

abstract class INewsRepository {
  Future<NewsResponse> fetchTopNews({required String country});

  Future<NewsResponse> fetchNewsByCategory(
      {required String country, required int page, required String category});

  Future<List<Article>> fetchSearchNews(
      {required String query,
      required String sortBy,
      required String language});
}
