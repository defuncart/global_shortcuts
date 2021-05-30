import 'dart:async';

import 'package:flutter/material.dart';
import 'package:global_shortcuts/global_shortcuts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _key = ShortcutKey.space;
  var _modifiers = [ShortcutModifier.control];
  var _isRegistered = false;
  var _outputString = '';

  Future<void> _register() async {
    late bool success;

    try {
      success = await GlobalShortcuts.register(
            key: _key,
            modifiers: _modifiers,
            onKeyCombo: _onKeyCombo,
          ) ??
          false;
    } on Exception catch (e) {
      print('An exception occurred while trying to register');
      print(e);
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
    } on Exception catch (e) {
      print('An exception occurred while trying to unregister');
      print(e);
    }

    if (mounted) {
      setState(() {
        _isRegistered = false;
        _outputString = '';
      });
    }
  }

  void _onKeyCombo() {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<ShortcutModifier>(
                    items: [
                      for (final modifier in ShortcutModifier.values)
                        DropdownMenuItem(
                          value: modifier,
                          child: Text(modifier.asString),
                        ),
                    ],
                    value: _modifiers.first,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        if (_isRegistered) {
                          _unregister();
                        }
                        setState(() => _modifiers = [newValue]);
                      }
                    },
                  ),
                  DropdownButton<ShortcutKey>(
                    items: [
                      for (final key in ShortcutKey.values)
                        DropdownMenuItem(
                          value: key,
                          child: Text(key.asString),
                        ),
                    ],
                    value: _key,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        if (_isRegistered) {
                          _unregister();
                        }
                        setState(() => _key = newValue);
                      }
                    },
                  ),
                ],
              ),
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
