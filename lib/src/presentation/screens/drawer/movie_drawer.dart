import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/presentation/themes/theme_colors.dart';

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
            color: ThemeColors.royalBlue.withOpacity(0.2),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 40,
            bottom: 10,
          ),
          child: Column(
            children: [
              const Placeholder(fallbackHeight: 40),
              NavigationListItem(
                label: 'Feedback',
                onPressed: () {},
              ),
              NavigationListItem(
                label: 'About',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationListItem extends StatelessWidget {
  const NavigationListItem({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: ThemeColors.royalBlue.withOpacity(0.2),
          )
        ],
      ),
      child: ListTile(
        title: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
