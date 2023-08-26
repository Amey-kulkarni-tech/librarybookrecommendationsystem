part of 'add_book_screen_bloc.dart';

@immutable
abstract class AddBookScreenEvent extends Equatable
{
  const AddBookScreenEvent();
}
class AddBookTagLoadEvent extends AddBookScreenEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InsertBookEvent extends AddBookScreenEvent
{
  final String bookName;
  final String authorName;
  final String bookPrice;
  final List<Tag> tags;

  InsertBookEvent({required this.bookName, required this.authorName, required this.bookPrice,required this.tags});
  @override
  // TODO: implement props
  List<Object?> get props => [bookName,authorName,bookPrice,tags];
}