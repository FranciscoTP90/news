// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum TopNewsStatus { initial, loading, success, error }

enum NewsByCategoryStatus { initial, loading, success, error }

enum AppLanguages { mx, us }

enum SortBy { publishedAt, relevancy, popularity }

class HomeState extends Equatable {
  final List<Article> topNews;
  final Map<String, NewsByCategoryModel> newsByCategory;
  final Map<String, List<Article>> prueba;
  final TopNewsStatus topNewsStatus;
  final NewsByCategoryStatus newsByCategoryStatus;
  final String selectedcategory;
  final Locale? locale;
  final Color appBarItemColor;
  final String sortBy;

  const HomeState(
      {required this.topNews,
      required this.newsByCategory,
      required this.newsByCategoryStatus,
      required this.topNewsStatus,
      required this.selectedcategory,
      required this.prueba,
      this.locale,
      required this.appBarItemColor,
      required this.sortBy});

  // ignore: prefer_const_constructors
  factory HomeState.initialState() => HomeState(
      topNews: const <Article>[],
      newsByCategory: const <String, NewsByCategoryModel>{},
      newsByCategoryStatus: NewsByCategoryStatus.initial,
      topNewsStatus: TopNewsStatus.initial,
      selectedcategory: "business",
      prueba: const <String, List<Article>>{},
      locale: null,
      appBarItemColor: Colors.white,
      sortBy: SortBy.publishedAt.name);

  @override
  List<Object?> get props => [
        topNews,
        newsByCategory,
        topNewsStatus,
        newsByCategoryStatus,
        selectedcategory,
        prueba,
        locale,
        appBarItemColor,
        sortBy
      ];

  HomeState copyWith(
      {List<Article>? topNews,
      Map<String, NewsByCategoryModel>? newsByCategory,
      TopNewsStatus? topNewsStatus,
      NewsByCategoryStatus? newsByCategoryStatus,
      String? selectedcategory,
      Map<String, List<Article>>? prueba,
      Locale? locale,
      Color? appBarItemColor,
      String? sortBy}) {
    return HomeState(
        topNews: topNews ?? this.topNews,
        newsByCategory: newsByCategory ?? this.newsByCategory,
        topNewsStatus: topNewsStatus ?? this.topNewsStatus,
        newsByCategoryStatus: newsByCategoryStatus ?? this.newsByCategoryStatus,
        selectedcategory: selectedcategory ?? this.selectedcategory,
        prueba: prueba ?? this.prueba,
        locale: locale ?? this.locale,
        appBarItemColor: appBarItemColor ?? this.appBarItemColor,
        sortBy: sortBy ?? this.sortBy);
  }
}

extension HomeStateExtension on HomeState {
  String get country => locale?.languageCode == 'es'
      ? AppLanguages.mx.name
      : AppLanguages.us.name;

  List<Article> get articlesByCategory =>
      newsByCategory[selectedcategory]?.newsResponse.articles ?? [];
  int get _total =>
      newsByCategory[selectedcategory]?.newsResponse.totalResults ?? 0;

  bool get hasMore => articlesByCategory.length < _total;

  Color get appBarBackroundColor =>
      appBarItemColor == Colors.white ? ColorsApp.dark : ColorsApp.scaffold;
}
