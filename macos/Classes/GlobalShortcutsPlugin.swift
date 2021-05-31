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
      register(call, result: result)
    case "unregister":
      unregister(self)
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func register(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if let args = call.arguments as? [String: Any],
      let keyAsString = args["key"] as? String,
      let key = Key(string: keyAsString),
      let modifiersAsString = args["modifiers"] as? [String],
      let modifiers = parseModifiers(modifiersAsString)
    {
      hotKey = HotKey(keyCombo: KeyCombo(key: key, modifiers: modifiers))
      result(true)
    } else {
      result(FlutterError(code: "Invalid argument(s)", message: nil, details: nil))
    }
  }

  private func unregister(_: Any?) {
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
        GlobalShortcutsPlugin.channel.invokeMethod("onKeyCombo", arguments: nil, result: nil)
      }
    }
  }

  private func parseModifiers(_ modifiersAsString: [String]) -> NSEvent.ModifierFlags? {
    var modifiers: NSEvent.ModifierFlags = []
    for modifierAsString in modifiersAsString {
      if let modifier = stringToModifier(modifierAsString) {
        modifiers.insert(modifier)
      } else {
        return nil
      }
    }

    return modifiers
  }

  private func stringToModifier(_ s: String) -> NSEvent.ModifierFlags? {
    switch s {
    case "capsLock":
      return NSEvent.ModifierFlags.capsLock
    case "shift":
      return NSEvent.ModifierFlags.shift
    case "control":
      return NSEvent.ModifierFlags.control
    case "option":
      return NSEvent.ModifierFlags.option
    case "command":
      return NSEvent.ModifierFlags.command
    case "numericPad":
      return NSEvent.ModifierFlags.numericPad
    case "help":
      return NSEvent.ModifierFlags.help
    case "function":
      return NSEvent.ModifierFlags.function
    default:
      return nil
    }
  }
}
