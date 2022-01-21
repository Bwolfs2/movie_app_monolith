import '../../common/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CardTrailer extends StatefulWidget {
  final String title, youtube;
  final VoidCallback onExitFullScreen;
  final int length;

  const CardTrailer({Key? key, required this.title, required this.youtube, required this.onExitFullScreen, required this.length})
      : super(key: key);

  @override
  _CardTrailerState createState() => _CardTrailerState();
}

// ignore: prefer_mixin
class _CardTrailerState extends State<CardTrailer> with WidgetsBindingObserver {
  late final _controller = YoutubePlayerController(
    initialVideoId: widget.youtube,
    flags: const YoutubePlayerFlags(
      mute: false,
      autoPlay: false,
      disableDragSeek: false,
      loop: false,
      isLive: false,
      forceHD: false,
      enableCaption: true,
    ),
  );

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    widget.onExitFullScreen();
    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    var ColorPalettes;
    return Container(
      width: Sizes.width(context) / 1.2,
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.dp10(context))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(Sizes.dp10(context))),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: ColorPalettes.darkAccent,
                topActions: <Widget>[
                  SizedBox(width: Sizes.dp8(context)),
                  Expanded(
                    child: Text(
                      _controller.metadata.title,
                      style: TextStyle(
                        color: ColorPalettes.white,
                        fontSize: Sizes.dp18(context),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
                // This for hide the full screen button
                bottomActions: [
                  SizedBox(width: Sizes.dp14(context)),
                  CurrentPosition(),
                  SizedBox(width: Sizes.dp8(context)),
                  ProgressBar(isExpanded: true),
                  RemainingDuration(),
                  const PlaybackSpeedButton(),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.length > 1 ? true : false,
            child: SizedBox(
              height: Sizes.dp10(context),
            ),
          ),
          Visibility(
            visible: widget.length > 1 ? true : false,
            child: Container(
              height: Sizes.dp30(context),
              width: Sizes.width(context),
              color: ColorPalettes.lightAccent,
              child: Center(
                child: Text(
                  'You must swipe here!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPalettes.white,
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.dp16(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
