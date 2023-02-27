import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../core/core.dart';
import '../../../../domain/domain.dart';
import '../../../widgets/widgets.dart';
import '../../bloc/home_bloc.dart';

class NewsByCategory extends StatelessWidget {
  const NewsByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final String category = state.selectedcategory;
        final List<Article> news = state.articlesByCategory;
        final bool hasMore = state.hasMore;

        return SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                childCount: news.isEmpty ? 1 : news.length + 1,
                (context, index) => Container(
                    color: ColorsApp.scaffold,
                    width: double.infinity,
                    child: _Item(
                      showEmpty: news.isEmpty,
                      showNewCard: index < news.length,
                      article: index < news.length ? news[index] : null,
                      category: category,
                      hasMore: hasMore,
                    ))),
            itemExtent: 350);
      },
    );
  }
}

class _Item extends StatelessWidget {
  final bool showEmpty;
  final bool showNewCard;
  final bool hasMore;
  final Article? article;
  final String? category;

  const _Item(
      {required this.showEmpty,
      required this.showNewCard,
      required this.hasMore,
      required this.article,
      this.category});

  @override
  Widget build(BuildContext context) {
    if (showEmpty) {
      return const EmptyNewCard(false);
    } else if (showNewCard) {
      return NewCard(
          isHorizontalList: false, article: article!, category: category);
    } else {
      return hasMore
          ? Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 30),
              child: const CircularProgressIndicator(color: ColorsApp.orange),
            )
          : Container(
              alignment: Alignment.topCenter,
              child: ElevatedButton.icon(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(ColorsApp.dark)),
                onPressed: () {
                  context.read<HomeBloc>().moveTop();
                },
                icon: const Icon(Ionicons.arrow_up_circle_outline),
                label: Text(AppLocalizations.of(context)!.goTop),
              ));
    }
  }
}
