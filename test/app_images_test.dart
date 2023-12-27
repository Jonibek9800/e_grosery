import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:el_grocer/resources/resources.dart';

void main() {
  test('app_images assets test', () {
    expect(File(AppImages.annaPelzer).existsSync(), isTrue);
    expect(File(AppImages.brookeLark).existsSync(), isTrue);
    expect(File(AppImages.defaultImages).existsSync(), isTrue);
    expect(File(AppImages.earth).existsSync(), isTrue);
    expect(File(AppImages.horse).existsSync(), isTrue);
    expect(File(AppImages.lilyBanse).existsSync(), isTrue);
    expect(File(AppImages.moto).existsSync(), isTrue);
    expect(File(AppImages.prototype).existsSync(), isTrue);
  });
}