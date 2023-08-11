part of 'studentdetailscreen_bloc.dart';

abstract class StudentdetailState extends Equatable {
  const StudentdetailState();
}

class StudentdetailInitial extends StudentdetailState {
  @override
  List<Object> get props => [];
}

class StudentdetailLoadedState extends StudentdetailState
{
  final List<Student> students;

  StudentdetailLoadedState(this.students);
  @override
  // TODO: implement props
  List<Object?> get props => [students];

}

class StudentdetailErrorState extends StudentdetailState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
