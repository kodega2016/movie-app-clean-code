import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_clean_code/src/common/constants/languages.dart';
import 'package:movie_app_clean_code/src/di/di.dart';
import 'package:movie_app_clean_code/src/presentation/app_localization.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/language/language_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/language/language_state.dart';
import 'package:movie_app_clean_code/src/presentation/themes/theme_colors.dart';
import 'package:movie_app_clean_code/src/presentation/wiredash_app.dart';

import 'screens/home/home_screen.dart';

class MovieApp extends StatefulWidget {
  const MovieApp({Key? key}) : super(key: key);

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  late LanguageBloc _languageBloc;

  @override
  void initState() {
    _languageBloc = getIt<LanguageBloc>();
    _languageBloc.add(ChangeLanguage(language: Lanuages.languages.first));
    super.initState();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        bloc: _languageBloc,
        builder: (context, state) {
          if (state is LanguageLoaded) {
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
                    unselectedWidgetColor: ThemeColors.royalBlue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    appBarTheme: const AppBarTheme(elevation: 0),
                    colorScheme: ColorScheme.fromSwatch()
                        .copyWith(secondary: ThemeColors.royalBlue),
                  ),
                  home: const MovieScreen(),
                  locale: Locale(state.language.code),
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
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
