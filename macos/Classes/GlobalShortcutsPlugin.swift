import Cocoa
import FlutterMacOS
import HotKey

public class GlobalShortcutsPlugin: NSObject, FlutterPlugin {
  static var channel: FlutterMethodChannel!

  public static func register(with registrar: FlutterPluginRegistrar) {
    channel = FlutterMethodChannel(name: "global_shortcuts", binaryMessenger: registrar.messenger)
    let instance = GlobalShortcutsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "register":
      register(self)
      result(true)
    case "unregister":
      unregister(self)
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func register(_: Any?) {
    // TODO: hardcoded
    hotKey = HotKey(keyCombo: KeyCombo(key: .space, modifiers: [.control]))
  }

  func unregister(_: Any?) {
    hotKey = nil
  }

  private var hotKey: HotKey? {
    didSet {
      guard let hotKey = hotKey else {
        // Unregistered
        return
      }

      // Registered
      hotKey.keyDownHandler = {
        GlobalShortcutsPlugin.channel.invokeMethod("onKeyDown", arguments: nil, result: nil)
      }
    }
  }
}
