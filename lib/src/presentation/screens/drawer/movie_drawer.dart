import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/common/constants/translation_constants.dart';
import 'package:movie_app_clean_code/src/common/extensions/string_extensions.dart';
import 'package:movie_app_clean_code/src/presentation/screens/drawer/navigation_expansion_list_item.dart';
import 'package:movie_app_clean_code/src/presentation/screens/drawer/navigation_list_item.dart';
import 'package:movie_app_clean_code/src/presentation/themes/theme_colors.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/about_us_dialog.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/movie_logo.dart';
import 'package:wiredash/wiredash.dart';

class MovieDrawer extends StatelessWidget {
  const MovieDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 0.4,
            color: ThemeColors.vulcan.withOpacity(0.8),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: MovieLogo(height: 30),
              ),
              NavigationExpansionListItem(
                label: TranslationConstants.language.t(context),
                children: const ['English', 'Spanish'],
                onPressed: () {},
              ),
              NavigationListItem(
                label: TranslationConstants.feedback.t(context),
                onPressed: () {
                  Navigator.pop(context);
                  Wiredash.of(context)?.show();
                },
              ),
              NavigationListItem(
                label: TranslationConstants.about.t(context),
                onPressed: () {
                  Navigator.pop(context);
                  _showAboutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAboutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return const AboutUsDialog(
            title: TranslationConstants.about,
            description: TranslationConstants.aboutDescription,
            buttonText: TranslationConstants.okay,
          );
        });
  }
}
