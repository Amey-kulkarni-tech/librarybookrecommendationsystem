import 'package:equatable/equatable.dart';

abstract class HomeScreenState extends Equatable{
const HomeScreenState();
}

abstract class HomeScreenActionState extends HomeScreenState
{}

class HomeScreenLoadingState extends HomeScreenState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeScreenLoadedState extends HomeScreenState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class HomeNavigateToAddStudentState extends HomeScreenState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
