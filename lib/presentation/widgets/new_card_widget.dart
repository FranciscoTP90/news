import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme/colors.dart';
import '../../core/utils/asset_location.dart';
import '../../domain/models/models.dart';
import '../home/views/components/article_action_btn.dart';
import 'category_widget.dart';

class NewCard extends StatelessWidget {
  final bool isHorizontalList;
  final Article article;
  final String? category;

  const NewCard(
      {super.key,
      required this.isHorizontalList,
      required this.article,
      this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detail',
            arguments: DetailArguments(
                category: category,
                article: article,
                isHorizontalList: isHorizontalList));
      },
      child: Container(
        width: 300,
        height: 350,
        color: Colors.white,
        margin: isHorizontalList
            ? const EdgeInsets.only(right: 20.0)
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Builder(
              builder: (context) {
                if (article.urlToImage == null) {
                  return Image.asset(
                    AssetLocation.placeholder,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                } else {
                  return Stack(
                    children: [
                      Hero(
                        tag: '$isHorizontalList-${article.title}',
                        child: CachedNetworkImage(
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: article.urlToImage!,
                          errorWidget: (context, url, error) => Image.asset(
                            AssetLocation.placeholder,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          placeholder: (context, url) => Image.asset(
                            AssetLocation.placeholder,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (category != null)
                        Positioned(
                            top: 10.0,
                            left: 10.0,
                            child: CategoryWidget(category!)),
                      const ArticleActionBtn(icon: Ionicons.heart_outline),
                      ArticleActionBtn(
                        icon: Ionicons.share_social_outline,
                        top: 60.0,
                        onTap: () {
                          try {
                            Share.share(article.url, subject: article.title);
                          } catch (e) {}
                        },
                      ),
                    ],
                  );
                }
              },
            )),
            const SizedBox(height: 10.0),
            Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: ColorsApp.dark,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 5.0),
            Text(
              AppLocalizations.of(context)!.date(article.publishedAt),
              style: const TextStyle(color: ColorsApp.scaffold),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}

class EmptyNewCard extends StatelessWidget {
  final bool isHorizontalList;
  const EmptyNewCard(this.isHorizontalList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 350,
      color: Colors.white,
      margin: isHorizontalList
          ? const EdgeInsets.only(right: 20.0)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image.asset(
            AssetLocation.placeholder,
            height: double.infinity,
            fit: BoxFit.cover,
            width: double.infinity,
          )),
          const SizedBox(height: 10.0),
          const Text(
            "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: ColorsApp.dark,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          const SizedBox(height: 5.0),
          const Text(
            "",
            style: TextStyle(color: ColorsApp.scaffold),
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
