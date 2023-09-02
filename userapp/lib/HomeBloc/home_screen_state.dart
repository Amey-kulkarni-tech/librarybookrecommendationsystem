part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
}

class HomeScreenInitial extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class LoadHomeDataState extends HomeScreenState{
  List<Book> book=[];
  List<Book> suggestions=[];

  LoadHomeDataState({required this.book,required this.suggestions});
  @override
  // TODO: implement props
  List<Object?> get props => [book,suggestions];

}

class LoadHomeDataErrorState extends HomeScreenState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}