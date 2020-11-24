// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ExampleTearOff {
  const _$ExampleTearOff();

// ignore: unused_element
  _Example call(int a) {
    return _Example(
      a,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Example = _$ExampleTearOff();

/// @nodoc
mixin _$Example {
  int get a;

  $ExampleCopyWith<Example> get copyWith;
}

/// @nodoc
abstract class $ExampleCopyWith<$Res> {
  factory $ExampleCopyWith(Example value, $Res Function(Example) then) =
      _$ExampleCopyWithImpl<$Res>;
  $Res call({int a});
}

/// @nodoc
class _$ExampleCopyWithImpl<$Res> implements $ExampleCopyWith<$Res> {
  _$ExampleCopyWithImpl(this._value, this._then);

  final Example _value;
  // ignore: unused_field
  final $Res Function(Example) _then;

  @override
  $Res call({
    Object a = freezed,
  }) {
    return _then(_value.copyWith(
      a: a == freezed ? _value.a : a as int,
    ));
  }
}

/// @nodoc
abstract class _$ExampleCopyWith<$Res> implements $ExampleCopyWith<$Res> {
  factory _$ExampleCopyWith(_Example value, $Res Function(_Example) then) =
      __$ExampleCopyWithImpl<$Res>;
  @override
  $Res call({int a});
}

/// @nodoc
class __$ExampleCopyWithImpl<$Res> extends _$ExampleCopyWithImpl<$Res>
    implements _$ExampleCopyWith<$Res> {
  __$ExampleCopyWithImpl(_Example _value, $Res Function(_Example) _then)
      : super(_value, (v) => _then(v as _Example));

  @override
  _Example get _value => super._value as _Example;

  @override
  $Res call({
    Object a = freezed,
  }) {
    return _then(_Example(
      a == freezed ? _value.a : a as int,
    ));
  }
}

/// @nodoc
class _$_Example implements _Example {
  _$_Example(this.a) : assert(a != null);

  @override
  final int a;

  @override
  String toString() {
    return 'Example(a: $a)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Example &&
            (identical(other.a, a) ||
                const DeepCollectionEquality().equals(other.a, a)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(a);

  @override
  _$ExampleCopyWith<_Example> get copyWith =>
      __$ExampleCopyWithImpl<_Example>(this, _$identity);
}

abstract class _Example implements Example {
  factory _Example(int a) = _$_Example;

  @override
  int get a;
  @override
  _$ExampleCopyWith<_Example> get copyWith;
}
