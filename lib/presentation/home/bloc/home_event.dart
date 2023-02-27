part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {
  factory HomeEvent.onFetchTopNews(
          {required String country, bool refresh = false}) =>
      _FetchTopNews(country: country, refresh: refresh);

  factory HomeEvent.onFetchNewsByCategory(
          {required String country, required String category}) =>
      _FetchNewsByCategory(category: category, country: country);

  factory HomeEvent.onCreate() => _Create();

  factory HomeEvent.onSelectCategory(
          {required String category, required String country}) =>
      _SelectCategory(category: category, country: country);

  factory HomeEvent.onChangeAppLanguage(Locale locale) =>
      _ChangeAppLanguage(locale);

  factory HomeEvent.onChangeAppBarColor() => _ChangeAppBarColor();

  factory HomeEvent.onSearch({required String query, required String sortBy}) =>
      _Search(query: query, sortBy: sortBy);

  factory HomeEvent.onChangeSortBy(String sortBy) => _ChangeSortBy(sortBy);
}

class _FetchTopNews implements HomeEvent {
  _FetchTopNews({required this.country, required this.refresh});
  final String country;
  final bool refresh;
}

class _FetchNewsByCategory implements HomeEvent {
  _FetchNewsByCategory({required this.category, required this.country});
  final String country;
  final String category;
}

class _Create implements HomeEvent {}

class _SelectCategory implements HomeEvent {
  _SelectCategory({required this.category, required this.country});

  final String category;
  final String country;
}

class _ChangeAppLanguage implements HomeEvent {
  _ChangeAppLanguage(this.locale);
  final Locale locale;
}

class _ChangeAppBarColor implements HomeEvent {}

class _Search implements HomeEvent {
  _Search({required this.query, required this.sortBy});
  final String query;
  final String sortBy;
}

class _ChangeSortBy implements HomeEvent {
  _ChangeSortBy(this.sortBy);
  final String sortBy;
}
