class Student
{
  final String fname;
  final String lname;
  final String mobileno;
  final String studentid;
  final String id;

  Student({
    required this.fname,
    required this.lname,
    required this.mobileno,
    required this.studentid,
    required this.id});

  factory Student.fromJson(Map<String,dynamic> json)
  {
    return Student(id:json["id"],
      studentid: json["student_id"],
      fname: json["stud_firstname"],
      lname: json["stud_lastname"],
      mobileno: json["stud_mobile"]
    );
  }

  // late String fname;
  //
  // set setfname(name){
  //   fname=name;
  // }
  // String get getfname{
  //   return fname;
  // }
  // late String lname;
  //
  // set setlname(name){
  //   lname=name;
  // }
  // String get getlname{
  //   return lname;
  // }
  // late String mobileno;
  // set setmobileno(no){
  //   mobileno=no;
  // }
  // String get getmobileno{
  //   return mobileno;
  // }
  //
  // late String studentid;
  //
  // set setstudentid(id){
  //   studentid=id;
  // }
  //
  //
  //
  // late int id;
  // set setid(i)
  // {
  //   id=i;
  // }
  // int get getid
  // {
  //   return id;
  // }


}