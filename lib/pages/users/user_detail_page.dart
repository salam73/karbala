import 'package:flutter/material.dart';
import 'package:karbala/models/mohammad.dart' as moh;
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import '../../widgets/picture_widget.dart';

class UserDetailPage extends StatefulWidget {
  final moh.Mohmmad mohammad;

  const UserDetailPage({Key? key, required this.mohammad}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late CachedVideoPlayerPlusController _videoController;

  @override
  void initState() {
    super.initState();
    if (widget.mohammad.properties?.video?.files != null &&
        widget.mohammad.properties!.video!.files.isNotEmpty) {
      _videoController = CachedVideoPlayerPlusController.networkUrl(
          Uri.parse(widget.mohammad.properties!.video!.files.first.file!.url),
        )
        ..initialize().then((_) {
          setState(() {}); // Ensure the UI updates after initialization
        });
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Detail')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.mohammad.properties?.title?.title[0].plainText ??
                    'no title',
                style: TextStyle(fontSize: 24),
              ),
              widget.mohammad.properties?.video?.files != null &&
                      widget.mohammad.properties!.video!.files.isNotEmpty
                  ?
                  //Text(widget.mohammad.properties!.video!.files.first.file!.url)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        _videoController.value.isInitialized
                            ? AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: CachedVideoPlayerPlus(_videoController),
                            )
                            : const CircularProgressIndicator(),
                  )
                  : const Text('No Video Available'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: PictureWidget(mohammad: widget.mohammad),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          widget.mohammad.properties?.video?.files != null &&
                  widget.mohammad.properties!.video!.files.isNotEmpty
              ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (_videoController.value.isPlaying) {
                      _videoController.pause();
                    } else {
                      _videoController.play();
                    }
                  });
                },
                child: Icon(
                  _videoController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
              )
              : null,
    );
  }
}
