import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_clean_code/src/common/constants/languages.dart';
import 'package:movie_app_clean_code/src/presentation/app_localization.dart';
import 'package:movie_app_clean_code/src/presentation/wiredash_app.dart';

import 'screens/home/home_screen.dart';

class MovieApp extends StatelessWidget {
  MovieApp({Key? key}) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: WiredashApp(
        navigationKey: _navigatorKey,
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Movie App Clean Code',
          theme: ThemeData(
            fontFamily: GoogleFonts.pangolin().fontFamily,
          ),
          home: const MovieScreen(),
          locale: Locale(Lanuages.languages[1].code),
          localizationsDelegates: const [
            AppLocalization.delegate,
            ...GlobalMaterialLocalizations.delegates,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales:
              Lanuages.languages.map((e) => Locale(e.code)).toList(),
        ),
      ),
    );
  }
}
