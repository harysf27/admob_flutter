import 'package:flutter/services.dart';
import 'admob_event_handler.dart';

class AdmobBannerController extends AdmobEventHandler {
  final MethodChannel _channel;
  final int id;

  AdmobBannerController(int id, Function(AdmobAdEvent, Map<String, dynamic>) listener)
      : _channel = MethodChannel('admob_flutter/banner_$id'), id = id,
        super(listener) {
        if (listener != null) {
          _channel.setMethodCallHandler(handleEvent);
          _channel.invokeMethod('setListener');
        }
      }

  void dispose() {
    _channel.invokeMethod('dispose'); // This is really isn't that useful b/c the next line kills everything about this view
    SystemChannels.platform_views.invokeMethod<void>('dispose', id);
  }
}
