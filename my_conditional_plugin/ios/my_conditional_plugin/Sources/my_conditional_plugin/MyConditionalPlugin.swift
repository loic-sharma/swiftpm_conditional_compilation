import Flutter
import UIKit

public class MyConditionalPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_conditional_plugin", binaryMessenger: registrar.messenger())
    let instance = MyConditionalPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getMessage":
      #if MY_CONDITIONAL_PLUGIN_SWITCH
      result("Switch on")
      #else
      result("Switch off")
      #endif
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
