import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'add_book_screen_event.dart';
part 'add_book_screen_state.dart';

class AddBookScreenBloc extends Bloc<AddBookScreenEvent, AddBookScreenState> {
  AddBookScreenBloc() : super(AddBookScreenInitial()) {
    on<AddBookScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
