import 'package:LRA/models/studentModel.dart';
import 'package:LRA/studentscreen/studentdetailBloc/studentdetailscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class StudentDetailScreen extends StatefulWidget {
  const StudentDetailScreen({Key? key}) : super(key: key);

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  int flag=1;
  final StudentdetailBloc studentdetailBloc=StudentdetailBloc();
  TextEditingController editingController = TextEditingController();
  List<Student> items=[];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => studentdetailBloc..add(StudentDetailLoadingEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text("Students Enrolled"),),
     body:Container(
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
               onChanged: (value) {
                 print("in change");
                 if(items.isNotEmpty)
                   {
                     studentdetailBloc.add(StudentdetailSearchBarEvent(items,value));
                   }
               },
               controller: editingController,
               decoration: InputDecoration(
                   labelText: "Search",
                   hintText: "Search",
                   prefixIcon: Icon(Icons.search),
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.all(Radius.circular(25.0)))),
             ),
           ),
           BlocConsumer<StudentdetailBloc,StudentdetailState>(
                builder:(context,state){
                  if(state is StudentdetailInitial)
                    {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  else if(state is StudentdetailErrorState)
                    {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(30),
                          height: 70,
                          decoration:  const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: const Center(
                            child: Text(
                                "Check Network. can't able to load Students ",
                              style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      );
                    }
                  else if(state is StudentdetailLoadedState)
                    {
                      if(flag==1)
                        {
                          items=state.students;
                          flag=2;
                        }
                      if(state.students.length==0)
                        {
                          return Center(
                            child: Text("No Student Found to Display"),
                          );
                        }
                          return Expanded(
                            child: ListView.builder(
                                itemCount: state.students.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      TextEditingController mobileController=TextEditingController();
                                      TextEditingController studentIDController=TextEditingController();
                                      TextEditingController lastNameController=TextEditingController();
                                      TextEditingController firstNameController=TextEditingController();
                                      showBottomSheet(context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top:Radius.circular(25.0)),
                                          ) ,

                                          backgroundColor: Colors.white,
                                          builder: (BuildContext context){
                                        firstNameController.text=state.students[index].fname;
                                        lastNameController.text=state.students[index].lname;
                                        mobileController.text=state.students[index].mobileno;
                                        studentIDController.text=state.students[index].studentid;
                                          return SizedBox(
                                              height: 0.7 * MediaQuery.of(context).size.height,
                                              child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                          onPressed:(){ Navigator.pop(context);},
                                                          icon: Icon(Icons.close,color: Colors.blue),
                                                        ),
                                                      ],
                                                    ),

                                                    Container(
                                                      color: Colors.white,

                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                        Container(
                                                          child:  Padding(
                                                            padding: EdgeInsets.all(15),
                                                            child: TextField(
                                                              readOnly: true,
                                                              textAlign: TextAlign.center,
                                                              controller: firstNameController,
                                                              decoration: InputDecoration(
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                                border: OutlineInputBorder(),
                                                                labelText: 'First Name',
                                                                hintText: 'Enter First Name',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                          Container(
                                                            child:  Padding(
                                                              padding: EdgeInsets.all(15),
                                                              child: TextField(
                                                                readOnly: true,
                                                                textAlign: TextAlign.center,
                                                                controller: lastNameController,
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: Colors.white,
                                                                  border: OutlineInputBorder(),
                                                                  labelText: 'Last Name',
                                                                  hintText: 'Enter Last Name',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child:  Padding(
                                                              padding: EdgeInsets.all(15),
                                                              child: TextField(
                                                                readOnly: true,
                                                                textAlign: TextAlign.center,
                                                                controller: studentIDController,
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: Colors.white,
                                                                  border: OutlineInputBorder(),
                                                                  labelText: 'Student ID',
                                                                  hintText: 'Enter Student ID',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child:  Padding(
                                                              padding: EdgeInsets.all(15),
                                                              child: TextField(
                                                                readOnly: true,
                                                                textAlign: TextAlign.center,
                                                                controller: mobileController,
                                                                decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: Colors.white,
                                                                  border: OutlineInputBorder(),
                                                                  labelText: 'Mobile Number',
                                                                  hintText: 'Enter Mobile no',
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(15.0),
                                                              child: ElevatedButton(
                                                                child: Text(
                                                                  'Delete Student',
                                                                  style: TextStyle(
                                                                      color: Colors.white, fontSize: 22),
                                                                ),
                                                                onPressed: (){
                                                                  studentdetailBloc.add(StudentdetailDeleteEvent(state.students[index]));
                                                                  Navigator.pop(context);
                                                               //  studentdetailBloc.add(StudentDetailLoadingEvent());
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(25)),
                                                                    primary: Colors.red
                                                                ),

                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                          );
                                          });
                                    },
                                    child: Card(
                                        child: ListTile(
                                            title: Text(state.students[index].fname+" "+items[index].lname),
                                            subtitle: Text(state.students[index].studentid),
                                            leading: CircleAvatar(
                                                backgroundImage:AssetImage("assets/studimg.jpg")
                                                ),
                                            trailing: Icon(Icons.book_outlined)
                                        )),
                                  );
                                }),
                          );
                    }
                      return Container();
                } ,
                listener: (context,state){
                  if(state is StudentdetailDeleteState)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.msg)),
                      );

                    }
            }),
         ],
       ),
     ),
    ),
    );
  }
}
