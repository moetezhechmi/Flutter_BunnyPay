import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kSpacingUnit = 10;

const kDarkPrimaryColorr = Color(0xFF212121);
const kDarkSecondaryColorr = Color(0xFF373737);
const kLightPrimaryColorr = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColorr,
);
final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 2),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

class ThemeProviderr extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: kDarkPrimaryColorr,
    canvasColor: kDarkPrimaryColorr,
    backgroundColor: kDarkSecondaryColorr,
    accentColor: kAccentColor,
    scaffoldBackgroundColor: Colors.grey.shade900,
    //primaryColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: ThemeData.dark().iconTheme.copyWith(
          color: kLightSecondaryColor,
        ),
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'SFProText',
          bodyColor: kLightSecondaryColor,
          displayColor: kLightSecondaryColor,
        ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: kLightPrimaryColorr,
    backgroundColor: kLightSecondaryColor,
    accentColor: kAccentColor,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: ThemeData.light().iconTheme.copyWith(
          color: kDarkSecondaryColorr,
        ),
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'SFProText',
          bodyColor: kDarkSecondaryColorr,
          displayColor: kDarkSecondaryColorr,
        ),
  );
}
