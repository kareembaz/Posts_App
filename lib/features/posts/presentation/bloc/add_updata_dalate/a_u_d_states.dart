import 'package:equatable/equatable.dart';

abstract class AddUpdataDeletePostStates extends Equatable {
  const AddUpdataDeletePostStates();
  @override
  List<Object?> get props => [];
}

class AddUpdataDeletePostInitial extends AddUpdataDeletePostStates {}

class LoadingAddUpdataDeletePostState extends AddUpdataDeletePostStates {}

class ErrorAddUpdataDeletePostState extends AddUpdataDeletePostStates {
  final String error;

  ErrorAddUpdataDeletePostState({required this.error});
  @override
  List<Object?> get props => [error];
}

class SuccessAddUpdataDeletePostState extends AddUpdataDeletePostStates {
  final String message;

  SuccessAddUpdataDeletePostState({required this.message});
  @override
  List<Object?> get props => [message];
}
