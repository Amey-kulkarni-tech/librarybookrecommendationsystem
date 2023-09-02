import 'dart:convert';

import 'package:LRA/models/bookModel.dart';
import 'package:http/http.dart';

import '../models/studentModel.dart';
import '../models/tagModel.dart';

class UserRepository
{
  final String BASE_URL='http://172.20.10.4/api';

  Future<int> enrollStudent(String firstName,String lastName,String mobileNumber,String StudentId)async
  {
    String reqUrl=BASE_URL+"/EnrollStudent/?fname="+firstName+"&lname="+lastName+"&studid="+StudentId+"&studmob="+mobileNumber+"";
    print(reqUrl);
    Response response=await get(Uri.parse(reqUrl));
    if(response.statusCode==200)
      {
        var data=jsonDecode(response.body);
        print(data);
        print(data["success"]);
          if(data["success"]==true)
            {
              return 200;
            }
          return 404;
      }
    else
      {
        print(response.reasonPhrase);
        throw Exception(response.reasonPhrase);
      }
  }

  Future<String> deleteStudent(Student student)async {
    String reqUrl = BASE_URL + "/DeleteStudent/?id=" + student.id;
    Response response = await get(Uri.parse(reqUrl));
    if (response.statusCode == 200) {
                  return response.body;
    }
    else{
      throw Exception(response.reasonPhrase);
    }
  }


  Future<List<Student>> getEnrolledStudent()async
  {
    String reqUrl=BASE_URL+"/EnrolledStudent/";
    Response response=await get(Uri.parse(reqUrl));
    if(response.statusCode==200)
      {
        var data=jsonDecode(response.body);
          List students=data;
          return students.map((e) => Student.fromJson(e)).toList();
      }
    else
      {
        throw Exception(response.reasonPhrase);
      }

  }



  Future<List<Tag>> getTags()async
  {
    String reqUrl=BASE_URL+"/GetTags/";
    Response response=await get(Uri.parse(reqUrl));
    if(response.statusCode==200)
    {
      var data=jsonDecode(response.body);
      List tag=data;
      return tag.map((e) => Tag.fromJson(e)).toList();
    }
    else
    {
      throw Exception(response.reasonPhrase);
    }

  }

  Future<int> insertBook(Book book)async
  {
    String tagsstring="";
    for(Tag t in book.taglist)
      {
        tagsstring=tagsstring+t.tagname+",";
      }
    String reqUrl=BASE_URL+"/InsertBook/?bname="+book.bookName+"&aname="+book.authorName+"&price="+book.bookPrice+"&tags="+tagsstring;
    print(reqUrl);
    Response response=await get(Uri.parse(reqUrl));
    if(response.statusCode==200)
    {
      if(response.body=="True")
      {
        return 200;
      }
      return 404;
    }
    else
    {
      print(response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }


  }


  Future<List<Book>> getAllBooks()async
  {
    String reqUrl=BASE_URL+"/GetBooks/";
    Response response=await get(Uri.parse(reqUrl));
    if(response.statusCode==200)
    {
      var data=jsonDecode(response.body);
      List books=data;
      return books.map((e) => Book.fromJson(e)).toList();
    }
    else
    {
      throw Exception(response.reasonPhrase);
    }

  }



  Future<String> deleteBook(Book book)async {
   String reqUrl = BASE_URL + "/DeleteBook/?bookId=" + book.id;
   print(reqUrl);
   Response response = await get(Uri.parse(reqUrl));
    if (response.statusCode == 200) {
      return response.body;
    }
    else{
      throw Exception(response.reasonPhrase);
    }
    return "aa";
  }





}