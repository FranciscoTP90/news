import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/core.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String url;
  final String title;
  const MyAppBar({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: ColorsApp.dark,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Ionicons.heart_outline)),
        IconButton(
            onPressed: () {
              try {
                Share.share(url, subject: title);
              } catch (e) {}
            },
            icon: const Icon(Ionicons.share_social_outline)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
