import 'package:flutter/foundation.dart' show describeEnum;

/// An enum to describe a shortcut modifier
///
/// https://developer.apple.com/documentation/appkit/nsevent/modifierflags
enum ShortcutModifier {
  capsLock,
  shift,
  control,
  option,
  command,
  numericPad,
  help,
  function,
}

extension ShortcutModifierExtensions on ShortcutModifier {
  String get asString => describeEnum(this);
}
