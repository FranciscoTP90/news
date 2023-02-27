import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class ArticleActionBtn extends StatelessWidget {
  final double top;
  final IconData icon;
  final Function()? onTap;
  const ArticleActionBtn(
      {super.key, this.top = 10.0, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 10.0,
        top: top,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                color: ColorsApp.container,
                borderRadius: BorderRadius.all(Radius.circular(2.0))),
            child: Icon(icon),
          ),
        ));
  }
}
