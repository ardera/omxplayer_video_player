part of omxplayer_video_player;

class OmxplayerView extends StatelessWidget {
  const OmxplayerView({
    Key key,
    @required this.playerId,
  }) : super(key: key);

  final int playerId;

  @override
  Widget build(BuildContext context) {
    return PlatformViewLink(
      viewType: 'omxplayer',
      onCreatePlatformView: _createOmxPlayerView,
      surfaceFactory: (BuildContext context, PlatformViewController controller) {
        return PlatformViewSurface(
          controller: controller,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
    );
  }

  _OmxPlayerViewController _createOmxPlayerView(PlatformViewCreationParams params) {
    final _OmxPlayerViewController controller = _OmxPlayerViewController(params.id, playerId);

    controller._initialize().then((_) {
      params.onPlatformViewCreated(params.id);
    });
    
    return controller;
  }
}

class _OmxPlayerViewController extends PlatformViewController {
  _OmxPlayerViewController(
    this.viewId,
    this.playerId
  );

  @override
  final int viewId;

  final int playerId;

  bool _initialized = false;

  Future<void> _initialize() async {
    await _PlatformInterface.instance.createPlatformView(playerId, viewId);
    _initialized = true;
  }

  @override
  void clearFocus() {
  }

  @override
  void dispatchPointerEvent(PointerEvent event) {
  }

  @override
  void dispose() {
    if (_initialized) {
      _PlatformInterface.instance.disposePlatformView(playerId, viewId);
    }
  }
}
