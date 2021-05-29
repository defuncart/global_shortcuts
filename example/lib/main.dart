import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_shortcuts/global_shortcuts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _isRegistered = false;
  var _outputString = '';

  Future<void> _register() async {
    late bool success;

    try {
      success = await GlobalShortcuts.register(_onKeyDown) ?? false;
    } on PlatformException {
      print('An exception occured while trying to register');
      success = false;
    }

    if (success != _isRegistered) {
      if (mounted) {
        setState(() => _isRegistered = success);
      }
    }
  }

  Future<void> _unregister() async {
    try {
      await GlobalShortcuts.unregister();
    } on PlatformException {
      print('An exception occured while trying to unregister');
    }

    if (mounted) {
      setState(() {
        _isRegistered = false;
        _outputString = '';
      });
    }
  }

  void _onKeyDown() {
    if (mounted) {
      setState(() => _outputString = 'Shortcut Pressed at ${DateTime.now()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('global_shortcuts'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Listens for CTRL+SPACE shortcut'),
              if (!_isRegistered)
                ElevatedButton(
                  onPressed: () async => _register(),
                  child: Text('Register'),
                ),
              if (_isRegistered)
                ElevatedButton(
                  onPressed: () async => _unregister(),
                  child: Text('Unregister'),
                ),
              Text(_outputString),
            ],
          ),
        ),
      ),
    );
  }
}
