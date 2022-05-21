import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/movie_logo.dart';

class MovieAppBar extends StatelessWidget {
  const MovieAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: SvgPicture.asset('assets/svgs/menu.svg'),
        ),
        const Expanded(
          child: MovieLogo(height: 30),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
