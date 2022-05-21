import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/presentation/themes/theme_colors.dart';

class NavigationSubListItem extends StatelessWidget {
  const NavigationSubListItem({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: ThemeColors.vulcan.withOpacity(0.2),
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
      ),
    );
  }
}
