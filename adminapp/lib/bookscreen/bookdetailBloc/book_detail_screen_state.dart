part of 'book_detail_screen_bloc.dart';

abstract class BookDetailScreenState extends Equatable {
  const BookDetailScreenState();
}

class BookDetailScreenInitial extends BookDetailScreenState {
  @override
  List<Object> get props => [];
}

class BookdetailLoadedState extends BookDetailScreenState
{
  final List<Book> books;

  BookdetailLoadedState(this.books);
  @override
  // TODO: implement props
  List<Object?> get props => [books];

}

class BookdetailErrorState extends BookDetailScreenState
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookdetailDeleteState extends BookDetailScreenState
{
  final String msg;

  BookdetailDeleteState(this.msg);
  @override
  // TODO: implement props
  List<Object?> get props => [msg];
}