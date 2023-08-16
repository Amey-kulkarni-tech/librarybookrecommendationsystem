import 'dart:async';
import 'dart:io';

import 'package:LRA/apis/UserRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/studentModel.dart';

part 'studentdetailscreen_event.dart';
part 'studentdetailscreen_state.dart';

class StudentdetailBloc extends Bloc<StudentdetailEvent, StudentdetailState> {
  StudentdetailBloc() : super(StudentdetailInitial()) {
    on<StudentDetailLoadingEvent>((event, emit)async {
          try{
            final List<Student> students=await UserRepository().getEnrolledStudent();
            emit(StudentdetailLoadedState(students));
          }catch(e)
      {
        emit(StudentdetailErrorState());
      }
    });

    on<StudentdetailSearchBarEvent>((event,emit){
      List<Student> items=event.students.where((element) => element.fname.toLowerCase().contains(event.query.toLowerCase())

      ).toList();
      emit(StudentdetailLoadedState(items));
    });

    on<StudentdetailDeleteEvent>((event,emit){
      try{
        UserRepository().deleteStudent(event.student);
        emit(StudentdetailDeleteState(event.student.fname+" deleted successfully !"));
        this.add(StudentDetailLoadingEvent());
      }catch(e)
      {
        emit(StudentdetailDeleteState("Student Not Deleted. Check network..!"));

      }
    });

  }
}
