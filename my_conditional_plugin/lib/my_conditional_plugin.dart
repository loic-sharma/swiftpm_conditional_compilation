
import 'my_conditional_plugin_platform_interface.dart';

class MyConditionalPlugin {
  Future<String?> getMessage() {
    return MyConditionalPluginPlatform.instance.getMessage();
  }
}
