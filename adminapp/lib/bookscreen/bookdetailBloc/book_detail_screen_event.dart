part of 'book_detail_screen_bloc.dart';

abstract class BookDetailScreenEvent extends Equatable {
  const BookDetailScreenEvent();
}


class BookDetailLoadingEvent extends BookDetailScreenEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class BookdetailSearchBarEvent extends BookDetailScreenEvent
{
  final List<Book> book;
  final String query;

  BookdetailSearchBarEvent(this.book, this.query);
  @override
  // TODO: implement props
  List<Object?> get props => [book,query];

}

class BookdetailDeleteEvent extends BookDetailScreenEvent
{
  final Book book;
  BookdetailDeleteEvent(this.book);
  @override
  // TODO: implement props
  List<Object?> get props => [book];
}