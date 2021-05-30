import 'dart:async';

import 'package:flutter/foundation.dart' show VoidCallback;
import 'package:flutter/services.dart';

import 'src/enums/shortcut_key.dart';
import 'src/enums/shortcut_modifier.dart';

export 'src/enums/shortcut_key.dart';
export 'src/enums/shortcut_modifier.dart';

class GlobalShortcuts {
  static const  _channel =  MethodChannel('global_shortcuts');

  /// Registers a global shortcut listener
  ///
  /// When [key] and [modifiers] are pressed, [onKeyCombo] will be invoked
  static Future<bool?> register({
    required ShortcutKey key,
    required List<ShortcutModifier> modifiers,
    required VoidCallback onKeyCombo,
  }) async {
    _channel.setMethodCallHandler(
      (methodCall) => _handler(methodCall, onKeyCombo),
    );

    final result = await _channel.invokeMethod(
      'register',
      <String, dynamic>{
        'key': key.asString,
        'modifiers': modifiers.map((modifier) => modifier.asString).toList(growable: false)
      },
    );

    return result;
  }

  static Future<dynamic> _handler(MethodCall methodCall, VoidCallback onKeyDown) async {
    switch (methodCall.method) {
      case 'onKeyCombo':
        onKeyDown();
        break;
      default:
        throw MissingPluginException('notImplemented');
    }
  }

  /// Unregisters the global shortcut listener
  static Future<void> unregister() async => await _channel.invokeMethod('unregister');
}
