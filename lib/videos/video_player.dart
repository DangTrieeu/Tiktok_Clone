import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/models/post_provider.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final int postIndex;
  const VideoPlayerItem({super.key, required this.videoUrl, required this.postIndex});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleLike() {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    postProvider.toggleLike(widget.postIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      onDoubleTap: _toggleLike,
      child: Stack(
        children: [
          _controller.value.isInitialized
              ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
              : const Center(child: CircularProgressIndicator()),

          // Icon pause/play hiện giữa màn hình
          if (!_isPlaying)
            const Center(
              child: Icon(Icons.play_arrow,
                  size: 80, color: Colors.white70),
            ),
        ],
      ),
    );
  }
}
