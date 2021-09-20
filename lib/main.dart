import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bunnypay007/widgets/Authentification.dart';
import 'package:bunnypay007/widgets/Menu.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:bunnypay007/provider/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'models/infowindow.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => InfoWindowModel(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProviderr(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProviderr>(context);

        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BunnyPay Project',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: SplashScreenView(
              navigateRoute: FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(),
                              width: 60,
                              height: 60,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text('Awaiting result...'),
                            )
                          ]),
                    );
                  } else if (snapshot.data.getString("idParent") == null) {
                    return Authentification();
                  } else {
                    return Menu();
                  }
                },
              ),
              duration: 5000,
              imageSize: 200,
              imageSrc: "assets/images/logofinal.png",
              text: "BunnyPay",
              textType: TextType.ColorizeAnimationText,
              textStyle: TextStyle(
                fontSize: 30.0,
              ),
              colors: [
                Color(0xff511f52),
                Color(0xffff88c4),
                Color(0xffebc2ec),
                Color(0xffb97898),


              ],
              backgroundColor: Colors.white,
            ));
      });
}
