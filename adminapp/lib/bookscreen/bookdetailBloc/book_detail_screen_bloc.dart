import 'dart:async';

import 'package:LRA/apis/UserRepository.dart';
import 'package:LRA/models/bookModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'book_detail_screen_event.dart';
part 'book_detail_screen_state.dart';

class BookDetailScreenBloc extends Bloc<BookDetailScreenEvent, BookDetailScreenState> {
  BookDetailScreenBloc() : super(BookDetailScreenInitial()) {
    on<BookDetailLoadingEvent>((event, emit)async {
      try{
       final List<Book> books=await UserRepository().getAllBooks();
        emit(BookdetailLoadedState(books));
      }catch(e)
      {
        emit(BookdetailErrorState());
      }
    });

    on<BookdetailSearchBarEvent>((event,emit){
      List<Book> items=event.book.where((element) => element.bookName.toLowerCase().contains(event.query.toLowerCase())
      ).toList();
      emit(BookdetailLoadedState(items));
    });

    on<BookdetailDeleteEvent>((event,emit){
      try{
        UserRepository().deleteBook(event.book);
        emit(BookdetailDeleteState(event.book.bookName+" deleted successfully !"));
        this.add(BookDetailLoadingEvent());
      }catch(e)
      {
        emit(BookdetailDeleteState("Book Not Deleted. Check network..!"));

      }
    });
  }
}
