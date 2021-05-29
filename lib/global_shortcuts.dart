import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GlobalShortcuts {
  static const _channel = MethodChannel('global_shortcuts');

  /// Registers a global shortcut listener
  ///
  /// On CRTL+SPACE [onKeyDown] will be invoked
  static Future<bool?> register(VoidCallback onKeyDown) async {
    _channel.setMethodCallHandler(
      (methodCall) => _handler(methodCall, onKeyDown),
    );

    final success = await _channel.invokeMethod('register') as bool?;
    return success;
  }

  static Future<dynamic> _handler(MethodCall methodCall, VoidCallback onKeyDown) async {
    switch (methodCall.method) {
      case 'onKeyDown':
        onKeyDown();
        break;
      default:
        throw MissingPluginException('notImplemented');
    }
  }

  /// Unregisters the global shortcut listener
  static Future<void> unregister() async => await _channel.invokeMethod('unregister');
}
