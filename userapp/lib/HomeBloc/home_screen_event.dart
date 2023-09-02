part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}
class LoadBookDataEvent extends HomeScreenEvent
{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

class SearchBookEvent extends HomeScreenEvent{
  final List<Book>  books;
  final List<Book> suggestions;
  final String query;

  SearchBookEvent(this.books,this.suggestions ,this.query);
  @override
  // TODO: implement props
  List<Object?> get props => [books,suggestions,query];

}

class BookLikedEvent extends HomeScreenEvent{
  final Book book;

  BookLikedEvent(this.book);
  @override
  // TODO: implement props
  List<Object?> get props => [book];
}