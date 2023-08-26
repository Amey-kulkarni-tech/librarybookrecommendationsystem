import 'dart:async';

import 'package:LRA/apis/UserRepository.dart';
import 'package:LRA/models/bookModel.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/tagModel.dart';

part 'add_book_screen_event.dart';
part 'add_book_screen_state.dart';

class AddBookScreenBloc extends Bloc<AddBookScreenEvent, AddBookScreenState> {
  AddBookScreenBloc() : super(AddBookScreenInitial()) {
    on<AddBookTagLoadEvent>((event,emit)async{
      try{
        final List<Tag> tags=await UserRepository().getTags();
        emit(AddBookTagLoadedState(tags));
      }catch(e)
      {
      }
    });
    on<InsertBookEvent>((event,emit)async{
      try{
        Book book=Book(id:"-1",bookName: event.bookName,authorName: event.authorName,bookPrice: event.bookPrice,taglist: event.tags);
        int status=await UserRepository().insertBook(book);
        if(status==200)
          {
            emit(BookInsertedState());
            emit(AddBookScreenInitial());
            this.add(AddBookTagLoadEvent());
          }
        else
          {
            emit(BookNotInsertedState());
          }
      }catch(e)
      {

      }
    });


  }


}
