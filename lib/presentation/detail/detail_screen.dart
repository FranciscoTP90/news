import 'package:flutter/material.dart';
import 'package:news/presentation/detail/components/components.dart';
import '../../domain/domain.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailArguments;
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: MyAppBar(url: args.article.url, title: args.article.title),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          width: size.width,
          height: size.height,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverTitleImg(args: args),
              SliverContent(
                  content: args.article.content,
                  description: args.article.description)
            ],
          ),
        ));
  }
}
