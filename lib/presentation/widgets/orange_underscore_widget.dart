import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class OrangeUnderscoreWidget extends StatelessWidget {
  const OrangeUnderscoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 30.0, child: Divider(color: ColorsApp.orange, thickness: 3));
  }
}
