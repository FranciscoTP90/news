import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../widgets/widgets.dart';
import '../../bloc/home_bloc.dart';
import 'search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SliverSearchTopNews extends StatelessWidget {
  const SliverSearchTopNews({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
        child: Stack(
      children: [
        Container(height: size.height * 0.4, color: ColorsApp.dark),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchForm(),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          AppLocalizations.of(context)!
                              .topHeadlines
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium!),
                      const OrangeUnderscoreWidget()
                    ])),
            const _TopNews(),
            Container(
                height: 20.0, width: double.infinity, color: ColorsApp.scaffold)
          ],
        ),
      ],
    ));
  }
}

class _TopNews extends StatefulWidget {
  const _TopNews();

  @override
  State<_TopNews> createState() => _TopNewsState();
}

class _TopNewsState extends State<_TopNews> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.topNews.isNotEmpty) {
          return _Background(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.topNews.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (BuildContext context, int index) {
                return NewCard(
                  isHorizontalList: true,
                  article: state.topNews[index],
                );
              },
            ),
          );
        } else {
          return SizedBox(
            height: 300,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (BuildContext context, int index) {
                return const EmptyNewCard(true);
              },
            ),
          );
        }
      },
    );
  }
}

class _Background extends StatelessWidget {
  final Widget child;
  const _Background({required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          Positioned(
              top: 0.0,
              child: Container(
                  height: 150, width: size.width, color: ColorsApp.dark)),
          Positioned(
              bottom: 0.0,
              child: Container(
                  height: 150, width: size.width, color: ColorsApp.scaffold)),
          child
        ],
      ),
    );
  }
}
