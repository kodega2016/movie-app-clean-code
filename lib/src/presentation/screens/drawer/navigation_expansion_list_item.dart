import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/presentation/screens/drawer/navigation_sub_list_tile.dart';
import 'package:movie_app_clean_code/src/presentation/themes/theme_colors.dart';

class NavigationExpansionListItem extends StatelessWidget {
  const NavigationExpansionListItem({
    Key? key,
    required this.label,
    required this.onPressed,
    this.children = const <String>[],
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final List<String> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: ThemeColors.vulcan.withOpacity(0.2),
          )
        ],
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        title: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white),
        ),
        children: children.map((e) {
          return NavigationSubListItem(
            label: e,
            onPressed: () {},
          );
        }).toList(),
      ),
    );
  }
}
