import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/language/language_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/language/language_state.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  const WiredashApp(
      {Key? key, required this.child, required this.navigationKey})
      : super(key: key);

  final Widget child;
  final GlobalKey<NavigatorState> navigationKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return Wiredash(
          projectId: 'movie-app-41482op',
          secret: 'thISGhEjiHw56mVszmu6coc30EExVP30',
          navigatorKey: navigationKey,
          options: WiredashOptionsData(
              locale: Locale((state as LanguageLoaded).language.code)),
          child: child,
        );
      },
    );
  }
}
