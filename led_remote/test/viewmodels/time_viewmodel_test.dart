import 'package:flutter_test/flutter_test.dart';
import 'package:led_remote/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TimeViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
