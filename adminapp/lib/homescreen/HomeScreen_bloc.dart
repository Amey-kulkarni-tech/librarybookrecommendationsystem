import 'package:LRA/homescreen/HomeScreen_event.dart';
import 'package:LRA/homescreen/HomeScreen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent,HomeScreenState>
{
  HomeScreenBloc():super(HomeScreenLoadingState())
  {
    on<LoadHomeScreenEvent>((event,emit)async{

      Future.delayed(Duration(seconds: 5));
      emit(HomeScreenLoadedState());
    });
  }

}