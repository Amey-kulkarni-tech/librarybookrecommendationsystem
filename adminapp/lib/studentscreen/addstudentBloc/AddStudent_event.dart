import 'package:equatable/equatable.dart';

abstract class AddStudentEvent extends Equatable
{}

class AddStudentLoadingEvent extends AddStudentEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddStudentLoadedEvent extends AddStudentEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddStudentEnrollEvent extends AddStudentEvent
{
  final String firstName;
  final String lastName;
  final String studentId;
  final String mobileNumber;

  AddStudentEnrollEvent({required this.firstName, required this.lastName, required this.studentId, required this.mobileNumber});
  @override
  // TODO: implement props
  List<Object?> get props => [firstName,lastName,studentId,mobileNumber];
}