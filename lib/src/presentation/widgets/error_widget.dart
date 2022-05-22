import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/common/constants/translation_constants.dart';
import 'package:movie_app_clean_code/src/common/extensions/string_extensions.dart';
import 'package:movie_app_clean_code/src/domain/entities/app_error.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/p_button.dart';
import 'package:wiredash/wiredash.dart';

class PErrorWidget extends StatelessWidget {
  const PErrorWidget(
      {Key? key, required this.errorType, required this.onPressed})
      : super(key: key);

  final ErrorType errorType;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (errorType == ErrorType.network
                    ? TranslationConstants.somethingWentWrong
                    : TranslationConstants.checkNetwork)
                .t(context),
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ButtonBar(
            children: [
              PButton(label: 'Retry', onPressed: onPressed),
              PButton(
                  label: 'Feedback',
                  onPressed: () {
                    Wiredash.of(context)?.show();
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
