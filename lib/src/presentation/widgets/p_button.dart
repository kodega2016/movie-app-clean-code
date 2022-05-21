import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/presentation/themes/theme_colors.dart';

class PButton extends StatelessWidget {
  const PButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            ThemeColors.royalBlue,
            ThemeColors.violet,
          ],
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context).textTheme.button?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
