import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/common/extensions/num_extensions.dart';
import 'package:movie_app_clean_code/src/data/core/api_constants.dart';
import 'package:movie_app_clean_code/src/domain/entities/movie_detail_entity.dart';
import 'package:movie_app_clean_code/src/presentation/themes/theme_colors.dart';

class BigPoster extends StatelessWidget {
  const BigPoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetailEntity movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ThemeColors.vulcan.withOpacity(0.4),
              ThemeColors.vulcan,
            ],
          )),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.imageUrl}${movie.posterPath}',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ListTile(
            title: Text(
              movie.title,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white,
                  ),
            ),
            subtitle: Text(
              movie.releaseDate,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Colors.white,
                  ),
            ),
            trailing: Text(
              movie.voteAverage.convertToPercentageString(),
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
