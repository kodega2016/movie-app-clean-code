import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_clean_code/src/common/constants/translation_constants.dart';
import 'package:movie_app_clean_code/src/common/extensions/string_extensions.dart';
import 'package:movie_app_clean_code/src/domain/entities/video_entity.dart';
import 'package:movie_app_clean_code/src/presentation/screens/watch_video/watch_video_arguments.dart';
import 'package:movie_app_clean_code/src/presentation/themes/theme_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchVideo extends StatefulWidget {
  const WatchVideo({Key? key, required this.watchVideoArguments})
      : super(key: key);

  final WatchVideoArguments watchVideoArguments;

  @override
  State<WatchVideo> createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo> {
  late List<VideoEntity> _players;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _players = widget.watchVideoArguments.videos;

    _controller = YoutubePlayerController(
      initialVideoId: _players.first.key,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.vulcan,
        title: Text(TranslationConstants.watchTrailers.t(context)),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: const ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
        ),
        builder: (context, player) {
          return Column(
            children: [
              player,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 1; i < _players.length; i++)
                        GestureDetector(
                          onTap: () async {
                            _controller.load(_players[i].key);
                            _controller.play();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  width: 120,
                                  errorWidget: (context, _, __) => const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  imageUrl: YoutubePlayer.getThumbnail(
                                    videoId: _players[i].key,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    _players[i].title,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
