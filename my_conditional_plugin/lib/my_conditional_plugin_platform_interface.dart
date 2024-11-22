import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_conditional_plugin_method_channel.dart';

abstract class MyConditionalPluginPlatform extends PlatformInterface {
  /// Constructs a MyConditionalPluginPlatform.
  MyConditionalPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyConditionalPluginPlatform _instance = MethodChannelMyConditionalPlugin();

  /// The default instance of [MyConditionalPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyConditionalPlugin].
  static MyConditionalPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyConditionalPluginPlatform] when
  /// they register themselves.
  static set instance(MyConditionalPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getMessage() {
    throw UnimplementedError('getMessage() has not been implemented.');
  }
}
