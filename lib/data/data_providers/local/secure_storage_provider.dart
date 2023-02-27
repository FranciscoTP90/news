import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news/data/data_providers/local/i_locale_data_provider.dart';

class SecureStorageProvider implements ILocalDataProvider {
  SecureStorageProvider({required FlutterSecureStorage storage})
      : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  @override
  Future<String> getLocale() async {
    try {
      final String? languageCode = await _storage.read(key: 'languageCode');

      if (languageCode != null) {
        return languageCode;
      }
      throw Exception('languageCode: null');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> writeLocale(String languageCode) async {
    try {
      await _storage.write(key: 'languageCode', value: languageCode);
      return languageCode;
    } catch (_) {
      throw Exception('writeLocale: null');
    }
  }
}
