import 'dart:convert';

import 'package:http/http.dart';

import '../models/studentModel.dart';

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

}