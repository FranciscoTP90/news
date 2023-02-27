// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'locale_bloc.dart';

enum LanguageCode { es, en }

enum Country { mx, us }

class LocaleState extends Equatable {
  final String languageCode;

  const LocaleState(this.languageCode);

  factory LocaleState.initialState() => LocaleState(LanguageCode.es.name);

  @override
  List<Object> get props => [languageCode];

  LocaleState copyWith({
    String? languageCode,
  }) {
    return LocaleState(
      languageCode ?? this.languageCode,
    );
  }
}

extension LocaleStateExtension on LocaleState {
  String get country =>
      languageCode == LanguageCode.es.name ? Country.mx.name : Country.us.name;
}
