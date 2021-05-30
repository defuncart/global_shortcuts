import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter_test/flutter_test.dart';
import 'package:global_shortcuts/global_shortcuts.dart';

void main() {
  group('ShortcutModifierExtensions', () {
    group('asString', () {
      final expected = ShortcutModifier.values.map((key) => describeEnum(key)).toList(growable: false);

      test('Expect correct values', () {
        for (var i = 0; i < ShortcutModifier.values.length; i++) {
          expect(ShortcutModifier.values[i].asString, expected[i]);
        }
      });
    });
  });
}
