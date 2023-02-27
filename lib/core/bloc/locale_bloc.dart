import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/domain/repositories/i_locale_repository.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc(this._iLocaleRepository) : super(LocaleState.initialState()) {
    on<_ChangeLocale>(_changeLanguageCode);
  }

  final ILocaleRepository _iLocaleRepository;

  Future<void> _changeLanguageCode(
      _ChangeLocale event, Emitter<LocaleState> emit) async {
    try {
      final languageCode =
          await _iLocaleRepository.saveLocale(event.languageCode);

      emit(state.copyWith(languageCode: languageCode));
    } catch (e) {}
  }
}
