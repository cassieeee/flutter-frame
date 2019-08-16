import 'component_index.dart';

class CommonHelper {
  // T 用于区分存储类型
  static void putObject<T>(String key, Object value) {
    switch (T) {
      case int:
        AppInstance.putInt(key, value);
        break;
      case double:
        AppInstance.putDouble(key, value);
        break;
      case bool:
        AppInstance.putBool(key, value);
        break;
      case String:
        AppInstance.putString(key, value);
        break;
      case List:
        AppInstance.putStringList(key, value);
        break;
      default:
        AppInstance.putString(key, value == null ? "" : json.encode(value));
        break;
    }
  }

    static LanguageModel getLanguageModel() {
    String _saveLanguage = AppInstance.getString(Constant.keyLanguage);
    if (ObjectUtil.isNotEmpty(_saveLanguage)) {
      Map userMap = json.decode(_saveLanguage);
      return LanguageModel.fromJson(userMap);
    }
    return null;
  }

  static String getThemeColor() {
    String _colorKey = AppInstance.getString(Constant.KEY_THEME_COLOR);
    if (ObjectUtil.isEmpty(_colorKey)) {
      _colorKey = 'blue';
    }
    return _colorKey;
  }

  static SplashModel getSplashModel() {
    String _splashModel = AppInstance.getString(Constant.KEY_SPLASH_MODEL);
    if (ObjectUtil.isNotEmpty(_splashModel)) {
      Map userMap = json.decode(_splashModel);
      return SplashModel.fromJson(userMap);
    }
    return null;
  }
}