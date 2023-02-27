import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../bloc/home_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return previous.appBarItemColor != current.appBarItemColor;
      },
      builder: (context, state) {
        return SliverAppBar(
          pinned: true,
          backgroundColor: state.appBarBackroundColor,
          title: Text(
            AppLocalizations.of(context)!.news,
            style: TextStyle(
              color: state.appBarItemColor,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Ionicons.menu_outline,
              color: state.appBarItemColor,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: _TranslateBtn(),
            )
          ],
        );
      },
    );
  }
}

class _TranslateBtn extends StatelessWidget {
  const _TranslateBtn();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
            child: DropdownButton(
          hint: Text(
            state.country.toUpperCase(),
            style: TextStyle(color: state.appBarItemColor, fontSize: 16),
          ),
          alignment: Alignment.center,
          style: const TextStyle(color: Colors.black),
          icon: Icon(
            Ionicons.language_outline,
            color: state.appBarItemColor,
          ),
          selectedItemBuilder: (BuildContext context) {
            return AppLanguages.values.map((value) {
              return Text(
                value.name,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              );
            }).toList();
          },
          items: AppLanguages.values.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
                value: e.name, child: Text(e.name.toUpperCase()));
          }).toList(),
          onChanged: (value) {
            final languageCode = value == 'mx' ? 'es' : 'en';
            context
                .read<HomeBloc>()
                .add(HomeEvent.onChangeAppLanguage(Locale(languageCode)));
          },
        ));
      },
    );
  }
}
