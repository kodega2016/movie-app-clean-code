import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/data/core/api_constants.dart';

class MovieCarouselCard extends StatelessWidget {
  const MovieCarouselCard({
    Key? key,
    required this.posterPath,
    required this.id,
    required this.title,
  }) : super(key: key);

  final String posterPath;
  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: '${ApiConstants.imageUrl}$posterPath',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5?.copyWith(),
          ),
        ],
      ),
    );
  }
}
