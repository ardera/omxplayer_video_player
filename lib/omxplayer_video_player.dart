library omxplayer_video_player;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

part 'platform_interface.dart';
part 'omxplayer_view.dart';

class _OmxplayerKey extends GlobalObjectKey {
  _OmxplayerKey(int playerId) : super(playerId);
}

class OmxplayerVideoPlayer extends VideoPlayerPlatform {
  OmxplayerVideoPlayer._();

  @override
  Future<void> init() => _PlatformInterface.instance.init();

  @override
  Future<void> dispose(int textureId) =>
      _PlatformInterface.instance.dispose(textureId);

  @override
  Future<int> create(DataSource dataSource) =>
      _PlatformInterface.instance.create(dataSource);

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) =>
      _PlatformInterface.instance.videoEventsFor(textureId);

  @override
  Future<void> setLooping(int textureId, bool looping) =>
      _PlatformInterface.instance.setLooping(textureId, looping);

  @override
  Future<void> play(int textureId) =>
      _PlatformInterface.instance.play(textureId);

  @override
  Future<void> pause(int textureId) =>
      _PlatformInterface.instance.pause(textureId);

  @override
  Future<void> setVolume(int textureId, double volume) =>
      _PlatformInterface.instance.setVolume(textureId, volume);

  @override
  Future<void> seekTo(int textureId, Duration position) =>
      _PlatformInterface.instance.seekTo(textureId, position);

  @override
  Future<Duration> getPosition(int textureId) =>
      _PlatformInterface.instance.getPosition(textureId);

  @override
  /// Omxplayer can only have one view.
  Widget buildView(int textureId)
    => OmxplayerView(
      key: _OmxplayerKey(textureId),
      playerId: textureId,
    );

  static void useAsImplementation() {
    VideoPlayerPlatform.instance = OmxplayerVideoPlayer._();
  }
}
