# global_shortcuts

A macOS plugin which can register a callback for a global keyboard shortcut.

As the shortcut is global, the callback will be triggered even when the app does not have focus.

## Installation

```yaml
dependencies:
  global_shortcuts:
    git:
      url: https://github.com/defuncart/global_shortcuts/
```

## Usage

Register a callback for a given `ShortcutKey` and zero or more `ShortcutModifier`

```dart
Future<void> register() async {
  try {
    await GlobalShortcuts.register(
      key: ShortcutKey.r,
      modifiers: [ShortcutModifier.shift, ShortcutModifier.command],
      onKeyCombo: _onKeyCombo,
    );
  } on Exception catch (_) {}
}

void _onKeyCombo() => print('Shortcut Pressed at ${DateTime.now()}');
```

Shortcut can be unregistered using

```dart
Future<void> unregister() async {
  try {
    await GlobalShortcuts.unregister();
  } on Exception catch (_) {}
}
```

Only one shortcut combo can be registered. If, for instance, CTRL+SPACE is registered after SHIFT+CMD+R, then the callback for SHIFT+CMD+R will no longer be invoked.

## Notes

* Presently the plugin only supports macOS. Windows support may be investigated, linux support is unlikely.
* macOS plugin uses [HotKey](https://github.com/soffes/HotKey/) which does not seem to support all modifiers (i.e fn) while os global shortcuts like CMD+SPACE do not seem to be caught.
* Due to 0.0.x versioning, package is presently experimental.

## Collaboration

Spotted any problems? Please open [an issue on GitHub](https://github.com/defuncart/global_shortcuts/issues)! Would like to work on a windows or linux version? Fork the repo and submit a PR!
