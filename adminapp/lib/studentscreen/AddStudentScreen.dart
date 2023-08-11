import 'package:LRA/studentscreen/addstudentBloc/AddStudent_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'addstudentBloc/AddStudent_bloc.dart';
import 'addstudentBloc/AddStudent_state.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formkey=GlobalKey<FormState>();
  final AddStudentBloc addStudentBloc=AddStudentBloc();


  @override
  Widget build(BuildContext context) {

    TextEditingController mobileController=TextEditingController();
    TextEditingController studentIDController=TextEditingController();
    TextEditingController lastNameController=TextEditingController();
    TextEditingController firstNameController=TextEditingController();
  return BlocProvider(
  create: (context){
    return addStudentBloc..add(AddStudentLoadedEvent());
  },
  child: Scaffold(
    appBar: AppBar(
      title: Text("Add student"),
    ),
    body: BlocConsumer<AddStudentBloc, AddStudentState>(
      listener: (context, state) {
      // TODO: implement listener
        if(state is AddStudentEnrolledState)
          {
            String msg=""+state.enrolledName+" is enrolled with "+state.enrolledId;
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(msg)),
            );
          }
        if(state is AddStudentEnrollErrorState)
        {
          String msg=" Something went wrong. please check network";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        }

    },
    builder: (context, state) {
     if(state is AddStudentLoadingState)
       {
         return const Center(
           child: CircularProgressIndicator(),
         );
       }
     else if(state is AddStudentLoadedState || state is AddStudentEnrolledState || state is AddStudentEnrollErrorState) {
       return  SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(12.0),
             child: Form(
                 key: _formkey,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.only(top: 20.0),
                       child: Center(
                         child: Container(
                           width: 200,
                           height: 150,
                           //decoration: BoxDecoration(
                           //borderRadius: BorderRadius.circular(40),
                           //border: Border.all(color: Colors.blueGrey)),
                           child: Image.asset('assets/student-logo-removebg-preview.png'),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: TextFormField(
                         // validator: ((value) {
                         //   if (value == null || value.isEmpty) {
                         //     return 'please enter some text';
                         //   } else if (value.length < 5) {
                         //     return 'Enter atleast 5 Charecter';
                         //   }

                         //   return null;
                         // }),
                         validator: MultiValidator([
                           RequiredValidator(errorText: 'Enter first named'),
                           MinLengthValidator(3,
                               errorText: 'Minimum 3 charecter filled name'),
                         ]),
                         controller: firstNameController,
                         decoration: InputDecoration(
                             hintText: 'Enter first Name',
                             labelText: 'First name',
                             prefixIcon: Icon(
                               Icons.person,
                               color: Colors.lightBlue,
                             ),
                             errorStyle: TextStyle(fontSize: 18.0),
                             border: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red),
                                 borderRadius:
                                 BorderRadius.all(Radius.circular(9.0)))),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: TextFormField(
                         validator: MultiValidator([
                           RequiredValidator(errorText: 'Enter last named'),
                           MinLengthValidator(3,
                               errorText:
                               'Last name should be atleast 3 charater'),
                         ]),
                         controller: lastNameController,
                         decoration: InputDecoration(
                             hintText: 'Enter last Name',
                             labelText: 'Last name',
                             prefixIcon: Icon(
                               Icons.person,
                               color: Colors.grey,
                             ),
                             errorStyle: TextStyle(fontSize: 18.0),
                             border: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red),
                                 borderRadius:
                                 BorderRadius.all(Radius.circular(9.0)))),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: TextFormField(
                         validator: MultiValidator([
                           RequiredValidator(errorText: 'Student ID is required'),
                           MinLengthValidator(12,
                               errorText: 'Student ID must be at least 12 digits long'),
                         ]),
                         controller: studentIDController,
                         decoration: InputDecoration(
                             hintText: 'Enter Student ID',
                             labelText: 'Student ID',
                             prefixIcon: Icon(
                               Icons.school,
                               color: Colors.lightBlue,
                             ),
                             errorStyle: TextStyle(fontSize: 18.0),
                             border: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red),
                                 borderRadius:
                                 BorderRadius.all(Radius.circular(9.0)))),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: TextFormField(
                         controller: mobileController,
                         validator: MultiValidator([
                           RequiredValidator(errorText: 'Enter mobile number'),

                         ]),
                         decoration: InputDecoration(
                             hintText: 'Mobile',
                             labelText: 'Mobile',
                             prefixIcon: Icon(
                               Icons.phone,
                               color: Colors.grey,
                             ),
                             border: OutlineInputBorder(
                                 borderSide: BorderSide(color: Colors.red),
                                 borderRadius:
                                 BorderRadius.all(Radius.circular(9)))),
                       ),
                     ),
                     Center(
                         child: Padding(
                           padding: const EdgeInsets.all(18.0),
                           child: Container(
                             // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                             child: ElevatedButton(
                               child: Text(
                                 'Enroll Student',
                                 style: TextStyle(
                                     color: Colors.white, fontSize: 22),
                               ),
                               onPressed: () {
                                 if (_formkey.currentState!.validate()) {
                                   print('form submiitted');
                                   print(mobileController.text);
                                   addStudentBloc.add(AddStudentEnrollEvent(firstName: firstNameController.text, lastName: lastNameController.text, studentId: studentIDController.text, mobileNumber: mobileController.text));
                                 }
                                 else {
                                   ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(content: Text(
                                         'Please Enter a valid info')),
                                   );
                                 }
                               },
                               style: ElevatedButton.styleFrom(
                                   shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(30)),
                                   primary: Colors.blue
                               ),

                             ),

                             width: MediaQuery
                                 .of(context)
                                 .size
                                 .width,

                             height: 50,
                           ),
                         )),
                   ],
                 )),
           ),
         );
     }
     return Container();
    },
    ),
  ),
);


  }
}
