

import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable
{
const HomeScreenEvent();
}

class LoadHomeScreenEvent extends HomeScreenEvent
{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
abstract class HomeSCreenActiveEvent extends HomeScreenEvent{}
class HomeScreenMenuClickedEvent extends HomeScreenEvent
{
final int menuIndex;
HomeScreenMenuClickedEvent({required this.menuIndex});
  @override
  // TODO: implement props
  List<Object?> get props => [menuIndex];

}