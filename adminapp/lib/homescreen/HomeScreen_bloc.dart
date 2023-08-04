import 'dart:async';

import 'package:LRA/homescreen/HomeScreen_event.dart';
import 'package:LRA/homescreen/HomeScreen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent,HomeScreenState>
{
  HomeScreenBloc():super(HomeScreenLoadingState())
  {
    on<LoadHomeScreenEvent>(loadHomeScreenEvent);
    on<HomeScreenMenuClickedEvent>(homeScreenMenuClickedEvent);
  }


  FutureOr<void> homeScreenMenuClickedEvent(HomeScreenMenuClickedEvent event, Emitter<HomeScreenState> emit) {
      if(event.menuIndex==1)
      {
        emit(HomeNavigateToAddStudentState());
      }else  if(event.menuIndex==2)
      {
        print("add Book");
      }
      else  if(event.menuIndex==3)
      {
        print("Student");
      }
      else  if(event.menuIndex==4)
      {
        print("Books");
      }

  }

  FutureOr<void> loadHomeScreenEvent(LoadHomeScreenEvent event, Emitter<HomeScreenState> emit) {
      emit(HomeScreenLoadedState());
  }
}