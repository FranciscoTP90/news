abstract class ILocaleRepository {
  Future<String> readLocale();
  Future<String> saveLocale(String languageCode);
}
