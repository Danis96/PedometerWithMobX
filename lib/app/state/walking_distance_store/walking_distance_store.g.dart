// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walking_distance_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WalkingDistanceStore on WalkingDistanceBase, Store {
  late final _$confirmTestAtom =
      Atom(name: 'WalkingDistanceBase.confirmTest', context: context);

  @override
  bool get confirmTest {
    _$confirmTestAtom.reportRead();
    return super.confirmTest;
  }

  @override
  set confirmTest(bool value) {
    _$confirmTestAtom.reportWrite(value, super.confirmTest, () {
      super.confirmTest = value;
    });
  }

  late final _$WalkingDistanceBaseActionController =
      ActionController(name: 'WalkingDistanceBase', context: context);

  @override
  void setConfirmTest(bool value) {
    final _$actionInfo = _$WalkingDistanceBaseActionController.startAction(
        name: 'WalkingDistanceBase.setConfirmTest');
    try {
      return super.setConfirmTest(value);
    } finally {
      _$WalkingDistanceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
confirmTest: ${confirmTest}
    ''';
  }
}
