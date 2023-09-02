import 'dart:convert';

import 'package:http/http.dart';
import 'package:userapp/model/bookModel.dart';

class UserRepository
{
  final String BASE_URL="http://172.20.10.4/api/UserAPI";
  static String token="";

  Future<String> loginUser(String studid,String pass) async
  {
    String reqUrl=BASE_URL+"/login.php?stud_id="+studid+"&password="+pass;
    print(reqUrl);
    Response response=await get(Uri.parse(reqUrl));
    if(response.statusCode==200)
      {
        return response.body;
      }
    return "False";
  }

  Future<String> loadBookData()async{
    String reqUrl=BASE_URL+"/?token="+token;
    print(reqUrl);
    Response response=await get(Uri.parse(reqUrl));

    if(response.statusCode==200)
      {
        //var data=jsonDecode(response.body);
        // List books=data["data"];
        // List suggestions=data[""]
        // books.map((e) => Book.fromJson(e)).toList();
        //
        return response.body;
      }
      return "False";
  }


  likeBook(Book book)async
  {
    String reqUrl=BASE_URL+"/like.php?bookId="+book.id+"&token="+token;
    print(reqUrl);
    Response response=await get(Uri.parse(reqUrl));
    if(response.statusCode==200)
      {
        print("done");
      }
  }

}