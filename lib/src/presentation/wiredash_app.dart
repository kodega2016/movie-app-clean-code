import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  const WiredashApp(
      {Key? key, required this.child, required this.navigationKey})
      : super(key: key);

  final Widget child;
  final GlobalKey<NavigatorState> navigationKey;

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'movie-app-41482op',
      secret: 'thISGhEjiHw56mVszmu6coc30EExVP30',
      navigatorKey: navigationKey,
      child: child,
    );
  }
}
