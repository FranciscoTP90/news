import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/widgets.dart';
import '../../bloc/home_bloc.dart';

class SliverCategories extends StatelessWidget {
  const SliverCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle categoriesStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(color: ColorsApp.dark);

    return SliverToBoxAdapter(
      child: Container(
        color: ColorsApp.scaffold,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.categories.toUpperCase(),
                style: categoriesStyle),
            const SizedBox(height: 10.0),
            Expanded(child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                final selectedCategory = state.selectedcategory;
                return ListView.builder(
                  itemCount: context.read<HomeBloc>().categories.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final String category =
                        context.read<HomeBloc>().categories[index];

                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (selectedCategory == category) {
                                return;
                              }

                              context.read<HomeBloc>().add(
                                  HomeEvent.onSelectCategory(
                                      category: category,
                                      country: context
                                          .read<HomeBloc>()
                                          .state
                                          .country));
                            },
                            child: Text(
                              AppLocalizations.of(context)!.category(category),
                              style: categoryStyle(selectedCategory, category),
                            ),
                          ),
                          if (selectedCategory == category)
                            const OrangeUnderscoreWidget()
                        ],
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  TextStyle categoryStyle(String selectedCategory, String category) {
    return TextStyle(
        color: (selectedCategory == category)
            ? ColorsApp.dark
            : ColorsApp.grey.withOpacity(0.6),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0);
  }
}
