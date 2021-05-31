import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter_test/flutter_test.dart';
import 'package:global_shortcuts/global_shortcuts.dart';

void main() {
  group('ShortcutKeyExtensions', () {
    group('asString', () {
      final expected = ShortcutKey.values
          .map((key) =>
              key == ShortcutKey.returnKey ? 'return' : describeEnum(key))
          .toList(growable: false);

      test('Expect correct values', () {
        for (var i = 0; i < ShortcutKey.values.length; i++) {
          expect(ShortcutKey.values[i].asString, expected[i]);
        }
      });
    });
  });
}
