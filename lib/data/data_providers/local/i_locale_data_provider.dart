abstract class ILocalDataProvider {
  Future<String> getLocale();
  Future<String> writeLocale(String languageCode);
}
