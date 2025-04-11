import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AnimatedVideoWidget extends StatefulWidget {
  final String videoAssetPath;
  final double height;

  const AnimatedVideoWidget({
    super.key,
    required this.videoAssetPath,
    this.height = 250,
  });

  @override
  State<AnimatedVideoWidget> createState() => _AnimatedVideoWidgetState();
}

class _AnimatedVideoWidgetState extends State<AnimatedVideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAssetPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox(
            height: widget.height,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        : const SizedBox(height: 250, child: Center(child: CircularProgressIndicator()));
  }
}
