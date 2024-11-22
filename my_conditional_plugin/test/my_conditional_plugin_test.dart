import 'package:flutter_test/flutter_test.dart';
import 'package:my_conditional_plugin/my_conditional_plugin.dart';
import 'package:my_conditional_plugin/my_conditional_plugin_platform_interface.dart';
import 'package:my_conditional_plugin/my_conditional_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyConditionalPluginPlatform
    with MockPlatformInterfaceMixin
    implements MyConditionalPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyConditionalPluginPlatform initialPlatform = MyConditionalPluginPlatform.instance;

  test('$MethodChannelMyConditionalPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyConditionalPlugin>());
  });

  test('getPlatformVersion', () async {
    MyConditionalPlugin myConditionalPlugin = MyConditionalPlugin();
    MockMyConditionalPluginPlatform fakePlatform = MockMyConditionalPluginPlatform();
    MyConditionalPluginPlatform.instance = fakePlatform;

    expect(await myConditionalPlugin.getPlatformVersion(), '42');
  });
}
