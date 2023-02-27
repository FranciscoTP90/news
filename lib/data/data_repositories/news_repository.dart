import '../../domain/domain.dart';

class NewsRepository implements INewsRepository {
  NewsRepository({required IRemoteDataProvider iRemoteDataProvider})
      : _iRemoteDataProvider = iRemoteDataProvider;

  final IRemoteDataProvider _iRemoteDataProvider;

  @override
  Future<NewsResponse> fetchNewsByCategory(
      {required String country,
      required int page,
      required String category}) async {
    try {
      final newsResponse = await _iRemoteDataProvider.getNewsByCategory(
          country: country, page: page, category: category);
      return newsResponse;
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<NewsResponse> fetchTopNews({required String country}) async {
    try {
      final newsResponse =
          await _iRemoteDataProvider.getTopNews(country: country);
      return newsResponse;
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Article>> fetchSearchNews(
      {required String query,
      required String sortBy,
      required String language}) async {
    try {
      final news = await _iRemoteDataProvider.getSearchNews(
          query: query, sortBy: sortBy, language: language);
      return news;
    } catch (e) {
      throw '$e';
    }
  }
}
