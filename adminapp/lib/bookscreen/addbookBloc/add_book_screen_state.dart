part of 'add_book_screen_bloc.dart';

@immutable
abstract class AddBookScreenState extends Equatable{}

class AddBookScreenInitial extends AddBookScreenState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

class AddBookTagLoadedState extends AddBookScreenState {
  final List<Tag> tags;

  AddBookTagLoadedState(this.tags);
  @override
  // TODO: implement props
  List<Object?> get props =>[tags];
}


class BookInsertedState extends AddBookScreenState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookNotInsertedState extends AddBookScreenState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}