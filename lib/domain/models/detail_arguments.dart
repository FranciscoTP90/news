import 'news_response.dart';

class DetailArguments {
  final String? category;
  final Article article;
  final bool isHorizontalList;

  DetailArguments(
      {required this.category,
      required this.article,
      required this.isHorizontalList});
}
