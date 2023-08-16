import 'package:equatable/equatable.dart';

abstract class AddStudentState extends Equatable
{}

class AddStudentLoadingState extends AddStudentState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddStudentLoadedState extends AddStudentState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddStudentEnrolledState extends AddStudentState{
  final String enrolledId;
  final String enrolledName;

  AddStudentEnrolledState({required this.enrolledId, required this.enrolledName});
  @override
  // TODO: implement props
  List<Object?> get props => [enrolledId,enrolledName];

}

class AddStudentEnrollErrorState extends AddStudentState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
