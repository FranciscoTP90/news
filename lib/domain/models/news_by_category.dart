// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'news_response.dart';

class NewsByCategoryModel {
  final int currentPage;
  final NewsResponse newsResponse;

  NewsByCategoryModel({
    required this.currentPage,
    required this.newsResponse,
  });

  NewsByCategoryModel copyWith({
    int? currentPage,
    NewsResponse? newsResponse,
  }) {
    return NewsByCategoryModel(
      currentPage: currentPage ?? this.currentPage,
      newsResponse: newsResponse ?? this.newsResponse,
    );
  }
}
