import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/colors.dart';
import '../widgets/new_card_widget.dart';

import '../../domain/models/news_response.dart';
import '../home/bloc/home_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.query, this.sortBy, this.contextArg})
      : super(key: key);
  final String? query;
  final String? sortBy;
  final BuildContext? contextArg;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Article>> searchNews;
  late Locale? locale;
  @override
  void initState() {
    super.initState();
    setState(() {
      locale = context.read<HomeBloc>().state.locale!;
    });
    searchNews = fetch();

    Future.microtask(() {
      Locale myLocale = Localizations.localeOf(widget.contextArg!);

      log("SearchScreen ESTADO: ${context.read<HomeBloc>().state.locale}");
      log("SearchScreen: ${myLocale.languageCode}");
    });
  }

  Future<List<Article>> fetch() async {
    try {
      final news = await context
          .read<HomeBloc>()
          .searchNews(query: widget.query!, sortBy: widget.sortBy!);
      return news;
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.scaffold,
      appBar: locale == null
          ? null
          : AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: ColorsApp.dark,
              title: Localizations.override(
                  context: widget.contextArg!,
                  delegates: AppLocalizations.localizationsDelegates,
                  locale: locale!,
                  child: Text(AppLocalizations.of(widget.contextArg!)!.news)),
            ),
      // title: widget.contextArg == null
      //     ? null
      //     : Text(AppLocalizations.of(widget.contextArg!)!.news)),
      body: FutureBuilder(
        future: searchNews,
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.error,
                  style: const TextStyle(color: ColorsApp.dark),
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewCard(
                      isHorizontalList: false, article: snapshot.data![index]);
                },
              );
            } else {
              return Center(
                child: Text(AppLocalizations.of(context)!.noResults,
                    style: const TextStyle(color: ColorsApp.dark)),
              );
            }
          } else {
            return const Center(
                child: CircularProgressIndicator(color: ColorsApp.orange));
          }
        },
      ),
    );
  }
}
