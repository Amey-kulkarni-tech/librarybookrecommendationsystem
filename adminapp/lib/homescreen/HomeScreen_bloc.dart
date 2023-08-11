import 'dart:async';

import 'package:LRA/bookscreen/AddBookScreen.dart';
import 'package:LRA/homescreen/HomeScreen_event.dart';
import 'package:LRA/homescreen/HomeScreen_state.dart';
import 'package:LRA/studentscreen/StudentDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../studentscreen/AddStudentScreen.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent,HomeScreenState>
{

  HomeScreenBloc():super(HomeScreenLoadingState())
  {
    on<LoadHomeScreenEvent>(loadHomeScreenEvent);
    on<HomeScreenMenuClickedEvent>(homeScreenMenuClickedEvent);
  }


  FutureOr<void> loadHomeScreenEvent(LoadHomeScreenEvent event, Emitter<HomeScreenState> emit) async{
    emit(HomeScreenLoadedState());
  }

  FutureOr<void> homeScreenMenuClickedEvent(HomeScreenMenuClickedEvent event, Emitter<HomeScreenState> emit) {
      if(event.menuIndex==1)
      {

        print("add Student");
        Navigator.push(event.context,MaterialPageRoute(builder: (context) => AddStudentScreen()));

        //emit(HomeNavigateToAddStudentState());
      }else  if(event.menuIndex==2)
      {
        print("add Book");
        Navigator.push(event.context, MaterialPageRoute(builder: (context)=> AddBookScreen()));
      }
      else  if(event.menuIndex==3)
      {
        print("Student");
        Navigator.push(event.context,MaterialPageRoute(builder: (context) => StudentDetailScreen()));
      }
      else  if(event.menuIndex==4)
      {
        print("Books");
      }

  }

}