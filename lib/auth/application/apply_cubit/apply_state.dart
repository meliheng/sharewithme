// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'apply_cubit.dart';

@immutable
abstract class ApplyState {}

class ApplyInitial extends ApplyState {}

class ApplySubmitting extends ApplyState {}

class ApplySubmitted extends ApplyState {}

class ApplyErrored extends ApplyState {}
