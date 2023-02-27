import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'components/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Locale myLocale = Localizations.localeOf(context);

      context.read<HomeBloc>().add(HomeEvent.onChangeAppLanguage(myLocale));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, Locale?>(
      selector: (state) {
        return state.locale;
      },
      builder: (context, Locale? locale) {
        if (locale == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Localizations(
          delegates: AppLocalizations.localizationsDelegates,
          locale: locale,
          child: const Scaffold(body: Body()),
        );
      },
    );
  }
}
