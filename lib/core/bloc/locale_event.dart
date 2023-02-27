part of 'locale_bloc.dart';

abstract class LocaleEvent {
  factory LocaleEvent.onChangeLocale(String languageCode) =>
      _ChangeLocale(languageCode);
}

class _ChangeLocale implements LocaleEvent {
  _ChangeLocale(this.languageCode);
  final String languageCode;
}
