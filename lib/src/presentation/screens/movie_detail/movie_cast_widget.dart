import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_clean_code/src/common/extensions/string_extensions.dart';
import 'package:movie_app_clean_code/src/data/core/api_constants.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/cast/cast_bloc.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/cast/cast_event.dart';
import 'package:movie_app_clean_code/src/presentation/blocs/cast/cast_state.dart';
import 'package:movie_app_clean_code/src/presentation/widgets/error_widget.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(builder: (context, state) {
      if (state is CastLoaded) {
        return SizedBox(
          height: 240,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.casts.length,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              final cast = state.casts[i];
              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl:
                              '${ApiConstants.imageUrl}${cast.profilePath}',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * 0.4,
                          errorWidget: (context, url, _) => const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      child: Column(
                        children: [
                          Text(
                            cast.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            cast.character.trimToFixedString,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      } else if (state is CastLoading) {
        return const Expanded(
            child: Center(child: CircularProgressIndicator()));
      } else if (state is CastError) {
        return PErrorWidget(
          onPressed: () {
            BlocProvider.of<CastBloc>(context).add(LoadCast(id: id));
          },
          errorType: state.errorType,
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
