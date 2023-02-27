import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../domain/domain.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._iNewsRepository) : super(HomeState.initialState()) {
    on<_FetchTopNews>(_fetchTopNews);
    on<_FetchNewsByCategory>(_fetchNewsByCategory3);
    on<_Create>(_init);
    on<_SelectCategory>(_selectCategory);
    on<_ChangeAppLanguage>(_changeLanguage);
    on<_ChangeAppBarColor>(_changeAppBarColor);
    on<_Search>(_search);
    on<_ChangeSortBy>(_changeSortBy);
  }

  final INewsRepository _iNewsRepository;

  final List<String> _categories = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];

  List<String> get categories => _categories;

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  final TextEditingController _textController = TextEditingController();
  TextEditingController get txtController => _textController;

  Future<void> _fetchTopNews(
      _FetchTopNews event, Emitter<HomeState> emit) async {
    emit(state.copyWith(topNewsStatus: TopNewsStatus.loading));
    final List<Article> news = [];

    try {
      final newsResponse =
          await _iNewsRepository.fetchTopNews(country: event.country);

      news.addAll(newsResponse.articles);

      emit(state.copyWith(topNews: news, topNewsStatus: TopNewsStatus.success));
    } catch (e) {
      emit(state.copyWith(topNewsStatus: TopNewsStatus.error));
    }
  }

  Future<void> _fetchNewsByCategory3(
      _FetchNewsByCategory event, Emitter<HomeState> emit) async {
    emit(state.copyWith(newsByCategoryStatus: NewsByCategoryStatus.loading));
    try {
      if (state.newsByCategory[event.category]!.newsResponse.totalResults <
          state.newsByCategory[event.category]!.newsResponse.articles.length) {
        emit(
            state.copyWith(newsByCategoryStatus: NewsByCategoryStatus.success));
        return;
      }
      final newsResponse = await _iNewsRepository.fetchNewsByCategory(
          country: event.country,
          page: state.newsByCategory[event.category]!.currentPage,
          category: event.category);

      final List<Article> newArticles =
          state.newsByCategory[event.category]!.newsResponse.articles;

      newArticles.addAll(newsResponse.articles);

      final int newPage = state.newsByCategory[event.category]!.currentPage + 1;

      final NewsByCategoryModel newsByCatModel =
          state.newsByCategory[event.category]!.copyWith(
              newsResponse: newsResponse.copyWith(articles: newArticles),
              currentPage: newPage);

      final Map<String, NewsByCategoryModel> nbCategory = state.newsByCategory;
      nbCategory[event.category] = newsByCatModel;
      emit(state.copyWith(
          newsByCategory: nbCategory,
          prueba: {event.category: newsResponse.articles},
          newsByCategoryStatus: NewsByCategoryStatus.success));

      animar();
    } catch (e) {
      emit(state.copyWith(newsByCategoryStatus: NewsByCategoryStatus.error));
    }
  }

  void _init(_Create event, Emitter<HomeState> emit) {
    final newsByCategory = {...state.newsByCategory};

    for (var category in _categories) {
      final entry = {
        category: NewsByCategoryModel(
            currentPage: 1,
            newsResponse:
                NewsResponse(status: '', totalResults: 0, articles: []))
      };

      newsByCategory.addEntries(entry.entries);
    }

    emit(state.copyWith(newsByCategory: newsByCategory));
  }

  void _selectCategory(_SelectCategory event, Emitter<HomeState> emit) {
    emit(state.copyWith(selectedcategory: event.category));

    if (state.newsByCategory[event.category] != null &&
        state
            .newsByCategory[event.category]!.newsResponse.articles.isNotEmpty) {
      return;
    }
    add(HomeEvent.onFetchNewsByCategory(
        country: event.country, category: event.category));
  }

  Future<List<Article>> _search(_Search event, Emitter<HomeState> emit) async {
    try {
      return [];
    } catch (e) {
      throw "$e";
    }
  }

  Future<List<Article>> searchNews(
      {required String query, required String sortBy}) async {
    try {
      final news = await _iNewsRepository.fetchSearchNews(
          query: query, sortBy: sortBy, language: state.locale!.languageCode);
      return news;
    } catch (e) {
      throw "$e";
    }
  }

  void _changeSortBy(_ChangeSortBy event, Emitter<HomeState> emit) {
    emit(state.copyWith(sortBy: event.sortBy));
  }

  void initScroll() {
    _scrollController.addListener(_listener);
  }

  void _listener() {
    final position = _scrollController.position;

    final maxScrollExtent = position.maxScrollExtent;
    final pixel = position.pixels + 40;
    final hasPaginate = pixel >= maxScrollExtent &&
        (state.newsByCategory[state.selectedcategory]!.newsResponse.articles
                .length <
            state.newsByCategory[state.selectedcategory]!.newsResponse
                .totalResults);
    if (hasPaginate &&
        (state.newsByCategoryStatus != NewsByCategoryStatus.loading)) {
      add(HomeEvent.onFetchNewsByCategory(
          country: state.country, category: state.selectedcategory));
    }
    if (_scrollController.positions.isNotEmpty) {
      add(HomeEvent.onChangeAppBarColor());
    }
  }

  @override
  Future<void> close() {
    _scrollController
      ..removeListener(_listener)
      ..dispose();

    _textController
      ..clear()
      ..dispose();
    return super.close();
  }

  void animar() {
    if (_scrollController.position.pixels + 100 <=
        _scrollController.position.maxScrollExtent) {
      return;
    }
    _scrollController.animateTo(_scrollController.position.pixels + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void _changeLanguage(_ChangeAppLanguage event, Emitter<HomeState> emit) {
    emit(state.copyWith(newsByCategory: {}));
    add(HomeEvent.onCreate());
    emit(state.copyWith(locale: event.locale));
    add(HomeEvent.onFetchTopNews(country: state.country));
    add(HomeEvent.onFetchNewsByCategory(
        country: state.country, category: state.selectedcategory));
  }

  void moveTop() {
    _scrollController.animateTo(
        //go to top of scroll
        0, //scroll offset to go
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }

  void _changeAppBarColor(_ChangeAppBarColor event, Emitter<HomeState> emit) {
    if (_scrollController.offset > 417) {
      if (state.appBarItemColor != ColorsApp.dark) {
        emit(state.copyWith(appBarItemColor: ColorsApp.dark));
      }
    } else {
      if (state.appBarItemColor == ColorsApp.dark) {
        emit(state.copyWith(appBarItemColor: Colors.white));
      }
    }
  }
}
