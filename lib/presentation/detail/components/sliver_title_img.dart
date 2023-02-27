import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/core.dart';
import '../../../domain/models/models.dart';
import '../../widgets/widgets.dart';

class SliverTitleImg extends StatelessWidget {
  final DetailArguments args;
  const SliverTitleImg({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.date(args.article.publishedAt),
            style: const TextStyle(color: ColorsApp.grey)),
        const SizedBox(height: 20.0),
        Text(args.article.title,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 20.0),
        Row(children: [
          Image.asset(AssetLocation.placeholder, height: 50, width: 50),
          const SizedBox(width: 10.0),
          Expanded(
              child: Text(args.article.author ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: ColorsApp.grey))),
          if (args.category != null) CategoryWidget(args.category!)
        ]),
        const SizedBox(height: 20.0),
        Hero(
          tag: '${args.isHorizontalList}-${args.article.title}',
          child: args.article.urlToImage == null
              ? Image.asset(AssetLocation.placeholder,
                  fit: BoxFit.cover, width: double.infinity)
              : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: args.article.urlToImage!,
                  errorWidget: (context, url, error) => Image.asset(
                    AssetLocation.placeholder,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  placeholder: (context, url) => Image.asset(
                    AssetLocation.placeholder,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        )
      ],
    ));
  }
}
