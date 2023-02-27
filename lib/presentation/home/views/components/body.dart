import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/presentation/home/views/components/components.dart';

import '../../../../core/core.dart';
import '../../bloc/home_bloc.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
    return _BackgroundGradient(
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return CustomScrollView(
          controller: homeBloc.scrollController,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: const [
            MySliverAppBar(),
            SliverSearchTopNews(),
            SliverCategories(),
            NewsByCategory(),
          ]);
    }));
  }
}

class _BackgroundGradient extends StatelessWidget {
  final Widget child;
  const _BackgroundGradient({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.35, 0.35],
              colors: [ColorsApp.dark, ColorsApp.scaffold])),
      child: child,
    );
  }
}
