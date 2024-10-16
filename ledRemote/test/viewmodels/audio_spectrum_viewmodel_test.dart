import 'package:flutter_test/flutter_test.dart';
import 'package:ledRemote/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('AudioSpectrumViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
