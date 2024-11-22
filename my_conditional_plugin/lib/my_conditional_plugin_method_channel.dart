import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_conditional_plugin_platform_interface.dart';

/// An implementation of [MyConditionalPluginPlatform] that uses method channels.
class MethodChannelMyConditionalPlugin extends MyConditionalPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_conditional_plugin');

  @override
  Future<String?> getMessage() async {
    return await methodChannel.invokeMethod<String>('getMessage');
  }
}
