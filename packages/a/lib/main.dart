import 'package:freezed_annotation/freezed_annotation.dart';

part 'main.freezed.dart';

@freezed
abstract class Example with _$Example {
  factory Example(int a) = _Example;
}
