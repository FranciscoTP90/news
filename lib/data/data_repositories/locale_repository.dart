import 'package:news/data/data_providers/local/i_locale_data_provider.dart';
import 'package:news/domain/repositories/i_locale_repository.dart';

class LocaleRepository implements ILocaleRepository {
  LocaleRepository({required ILocalDataProvider iLocalDataProvider})
      : _iLocalDataProvider = iLocalDataProvider;

  final ILocalDataProvider _iLocalDataProvider;

  @override
  Future<String> readLocale() async {
    try {
      final languageCode = await _iLocalDataProvider.getLocale();
      return languageCode;
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<String> saveLocale(String code) async {
    try {
      final languageCode = await _iLocalDataProvider.writeLocale(code);
      return languageCode;
    } catch (e) {
      throw '$e';
    }
  }
}
