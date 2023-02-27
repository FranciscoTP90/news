// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/theme/colors.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  const CategoryWidget(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: ColorsApp.container,
          borderRadius: BorderRadius.all(Radius.circular(2.0))),
      child: Text(
        AppLocalizations.of(context)!.category(category),
        style:
            const TextStyle(color: ColorsApp.grey, fontWeight: FontWeight.bold),
      ),
    );
  }
}
