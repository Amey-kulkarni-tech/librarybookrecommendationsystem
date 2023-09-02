part of 'login_screen_bloc.dart';

abstract class LoginScreenState extends Equatable {
  const LoginScreenState();
}

class LoginScreenInitial extends LoginScreenState {
  @override
  List<Object> get props => [];
}

class UserNotLoginedState extends LoginScreenState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UserLoginedState extends LoginScreenState{

  final String studId;
  final String pass;

  UserLoginedState({required this.studId,required this.pass});

  @override
  // TODO: implement props
  List<Object?> get props => [studId,pass];

}
class UserNotLoginedMessageState extends LoginScreenState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}