import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class UserRepository {
  static final UserRepository instance = UserRepository._internal();
  UserRepository._internal();

  final EncryptedSharedPreferences _prefs = EncryptedSharedPreferences();
  
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String emailAddress = '';

  static const String _kFirst = "profile_first";
  static const String _kLast = "profile_last";
  static const String _kPhone = "profile_phone";
  static const String _kEmail = "profile_email";

  Future<void> loadData() async {
    firstName = await _prefs.getString(_kFirst);
    lastName = await _prefs.getString(_kLast);
    phoneNumber = await _prefs.getString(_kPhone);
    emailAddress = await _prefs.getString(_kEmail);
  }

  Future<void> saveData() async {
    await _prefs.setString(_kFirst, firstName);
    await _prefs.setString(_kLast, lastName);
    await _prefs.setString(_kPhone, phoneNumber);
    await _prefs.setString(_kEmail, emailAddress);
  }
}
