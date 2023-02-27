import '../../../domain/models/news_response.dart';

abstract class IRemoteDataProvider {
  Future<NewsResponse> getTopNews({required String country});

  Future<NewsResponse> getNewsByCategory(
      {required String country, required int page, required String category});
  Future<List<Article>> getSearchNews(
      {required String query,
      required String sortBy,
      required String language});
}
