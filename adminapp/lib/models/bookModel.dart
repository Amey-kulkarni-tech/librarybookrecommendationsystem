import 'package:LRA/models/tagModel.dart';

class Book
{
  final String bookName;
  final String authorName;
  final String bookPrice;
  final List<Tag> taglist;
  final String id;

  Book({required this.id,required this.bookName,required this.authorName,required this.bookPrice,required this.taglist});

  factory Book.fromJson(Map<String,dynamic> json)
  {
    List tags=json["tags"];
    List<Tag> tag=tags.map((e) => Tag.fromJson(e)).toList();
    return Book(id:json["id"],
        bookName: json["bname"],
        authorName: json["aname"],
        bookPrice: json["price"],
        taglist:tag
    );
  }
}