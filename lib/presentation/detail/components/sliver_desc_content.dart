import 'package:flutter/material.dart';

import '../../../core/core.dart';

class SliverContent extends StatelessWidget {
  final String? content;
  final String? description;

  const SliverContent(
      {super.key, required this.content, required this.description});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        const SizedBox(height: 20.0),
        _TextWidget(description),
        const SizedBox(height: 20.0),
        _TextWidget(content)
      ],
    ));
  }
}

class _TextWidget extends StatelessWidget {
  final String? text;
  const _TextWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: TextAlign.justify,
      style: const TextStyle(color: ColorsApp.dark, fontSize: 16.0),
    );
  }
}
