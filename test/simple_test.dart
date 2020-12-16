import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be lowercase', () {
    String hello = "Hello World";

    expect(hello.toLowerCase(), "hello world");
  });
}
