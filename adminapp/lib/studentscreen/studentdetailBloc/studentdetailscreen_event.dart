part of 'studentdetailscreen_bloc.dart';

abstract class StudentdetailEvent extends Equatable {
  const StudentdetailEvent();
}

class StudentDetailLoadingEvent extends StudentdetailEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class StudentdetailSearchBarEvent extends StudentdetailEvent
{
  final List<Student> students;
  final String query;

  StudentdetailSearchBarEvent(this.students, this.query);
  @override
  // TODO: implement props
  List<Object?> get props => [students,query];

}

class StudentdetailDeleteEvent extends StudentdetailEvent
{
  final Student student;

  StudentdetailDeleteEvent(this.student);
  @override
  // TODO: implement props
  List<Object?> get props => [student];

}