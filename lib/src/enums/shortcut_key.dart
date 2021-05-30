import 'package:flutter/foundation.dart' show describeEnum;

/// An enum to describe a shortcut key
///
/// https://github.com/soffes/HotKey/blob/master/Sources/HotKey/Key.swift
enum ShortcutKey {
  // Letters
  a,
  b,
  c,
  d,
  e,
  f,
  g,
  h,
  i,
  j,
  k,
  l,
  m,
  n,
  o,
  p,
  q,
  r,
  s,
  t,
  u,
  v,
  w,
  x,
  y,
  z,

  // Numbers
  zero,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,

  // Symbols
  period,
  quote,
  rightBracket,
  semicolon,
  slash,
  backslash,
  comma,
  equal,
  grave, // Backtick
  leftBracket,
  minus,

  // Whitespace
  space,
  tab,
  returnKey,

  //  Modifiers
  command,
  rightCommand,
  option,
  rightOption,
  control,
  rightControl,
  shift,
  rightShift,
  function,
  capsLock,

  //  Navigation
  pageUp,
  pageDown,
  home,
  end,
  upArrow,
  rightArrow,
  downArrow,
  leftArrow,

  // Functions
  f1,
  f2,
  f3,
  f4,
  f5,
  f6,
  f7,
  f8,
  f9,
  f10,
  f11,
  f12,
  f13,
  f14,
  f15,
  f16,
  f17,
  f18,
  f19,
  f20,

  // Keypad
  keypad0,
  keypad1,
  keypad2,
  keypad3,
  keypad4,
  keypad5,
  keypad6,
  keypad7,
  keypad8,
  keypad9,
  keypadClear,
  keypadDecimal,
  keypadDivide,
  keypadEnter,
  keypadEquals,
  keypadMinus,
  keypadMultiply,
  keypadPlus,

  //  Misc
  escape,
  delete,
  forwardDelete,
  help,
  volumeUp,
  volumeDown,
  mute
}

extension ShortcutKeyExtensions on ShortcutKey {
  String get asString => this == ShortcutKey.returnKey ? 'return' : describeEnum(this);
}
