

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
BuildContext context;
HomeScreenMenuClickedEvent({required this.menuIndex,required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [menuIndex,context];

}