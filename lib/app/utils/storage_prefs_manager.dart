import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final StoragePrefsManager storagePrefs = StoragePrefsManager();

class StoragePrefsManager {
  late SharedPreferences sharedPrefInstance;
  late FlutterSecureStorage storageInstance;

  Future<void> init() async {
    sharedPrefInstance = await SharedPreferences.getInstance();
    storageInstance = const FlutterSecureStorage();
  }

  //Secure Storage
  static const String userDataKey = 'userData';
  static const String accessToken = 'accessToken';
  static const String firstRun = 'firstRun';
  static const String finishedOnBoarding = 'finishedOnboarding';

  Future<void> setValue(String key, String value) async {
    const IOSOptions options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
    await storageInstance.write(key: key, value: value, iOptions: options);
  }

  Future<String> getValue(String key) async {
    final String? result = await storageInstance.read(key: key);
    return result ?? '';
  }

  Future<void> deleteAll() async {
    await storageInstance.deleteAll();
  }

  Future<void> deleteForKey(String key) async {
    await storageInstance.delete(key: key);
  }

  Future<void> setEmailInShared(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', email);
  }

  Future<String> readEmailFromShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userEmail = prefs.getString('user_email');
    return userEmail ?? '';
  }

  Future<void> setLanguage(String language) async {
    if( !['si', 'en'].contains(language)) {
      await sharedPrefInstance.setString('language_code', 'si');
      return;
    }

    await sharedPrefInstance.setString('language_code', language);
  }

  Future<String> getLanguage() async {
    String? languageCode = sharedPrefInstance.getString('language_code');
    return languageCode ?? 'si';
  }

}
