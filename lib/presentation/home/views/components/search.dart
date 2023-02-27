import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';
import '../../../search/search_screen.dart';

import '../../../../core/theme/colors.dart';
import '../../bloc/home_bloc.dart';
import 'modal.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();

    return Container(
      decoration: const BoxDecoration(color: ColorsApp.grey),
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding:
          const EdgeInsets.only(left: 10, right: 5.0, top: 8.0, bottom: 5.0),
      child: TextFormField(
        controller: homeBloc.txtController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) {
          if (value.trim().isEmpty) return;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                    query: value,
                    sortBy: homeBloc.state.sortBy,
                    contextArg: context),
              ));
        },
        cursorColor: ColorsApp.orange,
        decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchAnything,
            prefixIcon:
                const Icon(Ionicons.search_outline, color: ColorsApp.scaffold),
            suffixIcon: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: ColorsApp.scaffold,
                    context: context,
                    builder: (_) {
                      return ModalView(contextArg: context);
                    });
              },
              child: const ColoredBox(
                color: ColorsApp.orange,
                child: Icon(Ionicons.options_outline, color: ColorsApp.dark),
              ),
            )),
      ),
    );
  }
}
