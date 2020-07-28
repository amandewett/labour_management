import 'package:intl/intl.dart';

class Constants {
  static const String APP_NAME = "Labour Management";
  static const String CODEFERNS = "Codeferns";
  static const String EMPTY_FIELD_ERROR = "Field can not be empty!";
  static const String PRESENT = "Present";
  static const String ABSENT = "Absent";

  //font families
  static const String BARCODE_FONT_FAMILY = "libreBarcode";
  static const String OPEN_SANS_FONT_FAMILY = "OpenSans";

  //shared preference keys
  static const String LOGIN_STATUS = "loginStatus";
  static const String USER_ID = "userId";
  static const String USER_NAME = "userName";
  static const String USER_EMAIL = "userEmail";
  static const String JWT_TOKEN = "jwtToken";

  //drawables
  static const String LOGIN_BG = "assets/drawables/login_bg.jpg";
  static const String LOGO_BLACK = "assets/drawables/logo_black.png";
  static const String LOGO_WHITE = "assets/drawables/logo_white.png";
}

//Date formats
DateFormat dateFormat = DateFormat('dd-MM-yyyy');
