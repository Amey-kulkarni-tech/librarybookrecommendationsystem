part of 'login_screen_bloc.dart';

abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();
}

class CheckLoginEvent extends LoginScreenEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginUserEvent extends LoginScreenEvent
{
  final String studid;
  final String pass;
  BuildContext context;

  LoginUserEvent(this.context,this.studid, this.pass);
  @override
  // TODO: implement props
  List<Object?> get props => [context,studid,pass];
}

