import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lab1/card_book/domain/person_bundle.dart';

class StorageBundleState extends Equatable {
  const StorageBundleState({this.field});

  final AsyncSnapshot<Iterable<PersonBundle>>? field;

  @override
  List<Object?> get props => [field];

  StorageBundleState copyWith({
    AsyncSnapshot<Iterable<PersonBundle>>? field,
  }) {
    return StorageBundleState(
      field: field ?? this.field,
    );
  }
}
