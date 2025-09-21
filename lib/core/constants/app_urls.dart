import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  static final coverFirestorage =
      '${dotenv.env['FIREBASE_STORAGE_URL']}covers%2F';
  static final songFirestorage =
      '${dotenv.env['FIREBASE_STORAGE_URL']}songs%2F';
  static const mediaAlt = 'alt=media';
}
