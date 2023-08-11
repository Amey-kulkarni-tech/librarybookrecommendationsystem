import 'dart:async';

import 'package:LRA/studentscreen/addstudentBloc/AddStudent_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../apis/UserRepository.dart';
import 'AddStudent_state.dart';

class AddStudentBloc extends Bloc<AddStudentEvent,AddStudentState>
{
  AddStudentBloc():super(AddStudentLoadingState())
  {
    on<AddStudentLoadedEvent>(addStudentLoadedEvent);
    on<AddStudentEnrollEvent>(addStudentEnrolledEvent);
  }

  FutureOr<void> addStudentLoadedEvent(AddStudentLoadedEvent event, Emitter<AddStudentState> emit) {
  emit(AddStudentLoadedState());
  }

  FutureOr<void> addStudentEnrolledEvent(AddStudentEnrollEvent event, Emitter<AddStudentState> emit)async {
        emit(AddStudentLoadingState());
        try{
        final int statuscode=  await UserRepository().enrollStudent(event.firstName, event.lastName, event.mobileNumber, event.studentId);
        if(statuscode==200)
          {
            emit(AddStudentEnrolledState(enrolledId: event.studentId,enrolledName: event.firstName));

          }
          else
            {
              emit(AddStudentEnrollErrorState());
            }
        }catch(e)
    {
      emit(AddStudentEnrollErrorState());
    }


  }
}