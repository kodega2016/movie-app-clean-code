import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/common/extensions/string_extensions.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/p_button.dart';

class AboutUsDialog extends StatelessWidget {
  const AboutUsDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
  }) : super(key: key);

  final String title;
  final String description;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.t(context),
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              description.t(context),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(height: 14),
            PButton(
              label: buttonText.t(context),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
