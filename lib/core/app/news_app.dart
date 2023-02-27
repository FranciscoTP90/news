import '../../data/data.dart';
import '../../presentation/home/bloc/home_bloc.dart';
import '../routes/routes_app.dart';
import '../theme/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class NewsAppState extends StatelessWidget {
  const NewsAppState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          //Puedes usar DioDataProvider o HttpDataProvider
          RepositoryProvider(
              create: (context) => NewsRepository(
                  // iRemoteDataProvider:
                  //     HttpDataProvider(client: http.Client()))),
                  iRemoteDataProvider: DioDataProvider(client: Dio()))),
          // RepositoryProvider(create: (context) => LocaleRepository(
          //   iLocalDataProvider: SecureStorageProvider(storage: FlutterSecureStorage())),)
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => HomeBloc(context.read<NewsRepository>())
                ..initScroll()
                ..add(HomeEvent.onCreate())),
          // BlocProvider(
          //   create: (context) => LocaleBloc(context.read<LocaleRepository>())..add(LocaleEvent.onChangeLocale(LanguageCode.es.name)),

          // )
        ], child: const NewsApp()));
  }
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      initialRoute: RoutesApp.home,
      routes: RoutesApp.routes,
      theme: ThemeApp.themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
