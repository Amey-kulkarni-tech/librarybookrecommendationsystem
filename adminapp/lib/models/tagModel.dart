
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';

class Tag extends Taggable
{
  final String tagname;
  final String id;

  Tag({required this.tagname,required this.id});

  @override
  List<Object> get props => [tagname];

  factory Tag.fromJson(Map<String,dynamic> json)
  {
    return Tag(id:json["id"].toString(),
        tagname: json["tag_name"],
    );
  }

  String toJson() => '''  {
    "name": $tagname,\n
    "position": $id\n
  }''';
}