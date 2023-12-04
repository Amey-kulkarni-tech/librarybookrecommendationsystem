import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:userapp/api/UserRepository.dart';
import 'package:userapp/model/bookModel.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<LoadBookDataEvent>((event, emit)async {
      // TODO: implement event handler
      try {
        String dt = await UserRepository().loadBookData();
        var data = jsonDecode(dt);
        if(data["success"]==true) {
          List books = data["data"];
          List<Book> book = books.map((e) => Book.fromJson(e)).toList();

          List<Book> sug=[];
          if(data["suggestions"]!=null)
            {
              List suggestions = [];
             suggestions=data["suggestions"];
             sug = suggestions.map((e) => Book.fromJson(e)).toList();
             // sug.forEach((element) {
             //   //book.insert(0, element);
             //   book.add(element);
             // });
            }
          book.shuffle();
          emit(LoadHomeDataState(book: book, suggestions: sug));
        }
        else if(data["success"]==false){
          emit(LoadHomeDataErrorState());
        }
      }
      catch(e)
      {
              print("\n\nException : "+e.toString());
              emit(LoadHomeDataErrorState());
      }

    });

    on<SearchBookEvent>((event,emit){
        List<Book> items1=event.books.where((element) => element.bookName.toLowerCase().contains(event.query.toLowerCase())
        ).toList();
        List<Book> items2=event.suggestions.where((element) => element.bookName.toLowerCase().contains(event.query.toLowerCase())
        ).toList();
        emit(LoadHomeDataState(book: new List.from(items1.reversed),suggestions: items2));
    });

    on<BookLikedEvent>((event,emit)async{
      try {
        if (event.book.isliked == 1) {
          UserRepository().likeBook(event.book);
        }
        else if (event.book.isliked == 0)
        {
          UserRepository().dislikeBook(event.book);
        }

      }catch(e)
      {
        print(e);
      }
      });

  }
}
