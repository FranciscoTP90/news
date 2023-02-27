import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../core/theme/colors.dart';
import '../../../search/search_screen.dart';
import '../../bloc/home_bloc.dart';

class ModalView extends StatelessWidget {
  final BuildContext contextArg;
  const ModalView({super.key, required this.contextArg});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeBloc = context.read<HomeBloc>();

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const _GreyLineWidget(),
          Text(AppLocalizations.of(contextArg)!.select,
              style: const TextStyle(
                  color: ColorsApp.dark,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: SortBy.values.length,
              itemBuilder: (BuildContext context, int index) {
                return BlocSelector<HomeBloc, HomeState, String>(
                  selector: (state) {
                    return state.sortBy;
                  },
                  builder: (context, state) {
                    final String name = SortBy.values[index].name;
                    final bool isSelected = name == state;

                    return _SortByItem(
                        contextArg: contextArg,
                        isSelected: isSelected,
                        name: name);
                  },
                );
              },
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
                Navigator.push(
                    contextArg,
                    MaterialPageRoute(
                      builder: (contextArg) => SearchScreen(
                          contextArg: contextArg,
                          query: homeBloc.txtController.text,
                          sortBy: homeBloc.state.sortBy),
                    ));
              },
              style: btnStyle(context),
              icon: const Icon(Ionicons.search),
              label: Text(AppLocalizations.of(contextArg)!.search)),
          const SizedBox(height: 50.0)
        ],
      ),
    );
  }

  ButtonStyle btnStyle(BuildContext context) {
    return ButtonStyle(
        fixedSize: MaterialStatePropertyAll(
            Size(MediaQuery.of(context).size.width, 50)),
        padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        backgroundColor: const MaterialStatePropertyAll(ColorsApp.dark));
  }
}

class _GreyLineWidget extends StatelessWidget {
  const _GreyLineWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: ColorsApp.grey,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: 50,
      height: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
    );
  }
}

class _SortByItem extends StatelessWidget {
  final String name;
  final bool isSelected;
  final BuildContext contextArg;
  const _SortByItem(
      {required this.name, required this.isSelected, required this.contextArg});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<HomeBloc>().add(HomeEvent.onChangeSortBy(name));
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              color: isSelected
                  ? ColorsApp.orange.withOpacity(0.5)
                  : ColorsApp.grey.withOpacity(0.1)),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(36)),
                    color: isSelected ? ColorsApp.orange : Colors.white),
                child: isSelected
                    ? const Icon(Ionicons.checkmark, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 10.0),
              Text(
                AppLocalizations.of(contextArg)!.sortBy(name),
                style: const TextStyle(
                    color: ColorsApp.grey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
