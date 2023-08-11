import 'package:LRA/models/studentModel.dart';
import 'package:LRA/studentscreen/studentdetailBloc/studentdetailscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                          return Expanded(
                            child: ListView.builder(
                                itemCount: state.students.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      child: ListTile(
                                          title: Text(state.students[index].fname+" "+items[index].lname),
                                          subtitle: Text(state.students[index].studentid),
                                          leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                                          trailing: Icon(Icons.account_balance)
                                      ));
                                }),
                          );
                    }
                      return Container();
                } ,
                listener: (context,state){

            }),
         ],
       ),
     ),
    ),
    );
  }
}
