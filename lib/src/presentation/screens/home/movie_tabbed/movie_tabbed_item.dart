import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/presentation/themes/theme_colors.dart';

class MovieTabbedItem extends StatelessWidget {
  const MovieTabbedItem({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(height: 4),
            Container(
              height: 4,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: isSelected
                    ? const LinearGradient(colors: [
                        ThemeColors.royalBlue,
                        ThemeColors.violet,
                      ])
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
