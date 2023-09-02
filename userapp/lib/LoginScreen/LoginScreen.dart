import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:userapp/LoginScreen/login_screen_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenBloc loginScreenBloc=LoginScreenBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginScreenBloc..add(CheckLoginEvent()),
      child: Scaffold(
        backgroundColor: Color(0xffF7EBE1),
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Color(0xFF213333),
        ),
        body: BlocConsumer<LoginScreenBloc,LoginScreenState>(
        builder:(context,state){
          final _formkey=GlobalKey<FormState>();
          if(state is LoginScreenInitial)
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

          if(state is UserNotLoginedState)
            {
              TextEditingController studentIdController=TextEditingController();
              TextEditingController passwordController=TextEditingController();
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
                                child: Image.asset('assets/images/loginlogo.png'),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.fromLTRB(28.0,12.0,28.0,6.0),
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
                              controller: studentIdController,
                              decoration: InputDecoration(
                                  hintText: 'Enter Student ID',
                                  labelText: 'Student ID',
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
                            padding: const EdgeInsets.fromLTRB(28.0, 12.0, 28.0, 12.0),
                            child: TextFormField(

                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Enter password'),
                                MinLengthValidator(3,
                                    errorText:
                                    'password should be atleast 3 charater'),
                              ]),
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Enter password',
                                  labelText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: Colors.grey,
                                  ),
                                  errorStyle: TextStyle(fontSize: 18.0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(9.0)))),
                            ),
                          ),
                          Center(
                              child: Padding(
                                padding: const EdgeInsets.all(55.0),
                                child: Container(
                                  // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                                  child: ElevatedButton(
                                    child: Text(
                                      'Login ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        print('form submiitted');
                                       // print(mobileController.text);
                                        loginScreenBloc.add(LoginUserEvent(context,studentIdController.text, passwordController.text));
                                       // addStudentBloc.add(AddStudentEnrollEvent(firstName: firstNameController.text, lastName: lastNameController.text, studentId: studentIDController.text, mobileNumber: mobileController.text));
                                      }
                                      else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text(
                                              'Please enter a valid login credincial')),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        primary:  Color(0xFF213333)
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

          if(state is UserLoginedState)
            {
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
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.5,
                                //decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(40),
                                //border: Border.all(color: Colors.blueGrey)),
                                child: Image.asset('assets/images/alreadyloginimage.png'),
                              ),
                            ),
                          ),
                          Center(
                              child: Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: Container(
                                  // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Student ID : "+state.studId,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_rounded,
                                            color: Colors.white),
                                      ],
                                    ),


                                    // Text(
                                    //   state.studId+' ',
                                    //   style: TextStyle(
                                    //       color: Colors.white, fontSize: 22),
                                    // ),
                                    onPressed: () {
                                        print('form submiitted');
                                        // print(mobileController.text);
                                        loginScreenBloc.add(LoginUserEvent(context,state.studId,state.pass));
                                        // addStudentBloc.add(AddStudentEnrollEvent(firstName: firstNameController.text, lastName: lastNameController.text, studentId: studentIDController.text, mobileNumber: mobileController.text));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)),
                                        primary:  Color(0xFF213333)
                                    ),

                                  ),

                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,

                                  height: 50,
                                ),
                              )
                          ),

                          // Center(
                          //   child: InkWell(
                          //     onTap: (){
                          //       loginScreenBloc.add(LoginUserEvent(context,state.studId,state.pass));
                          //     },
                          //     child: Padding(
                          //       padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          //       child: Row(
                          //         mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             "Let's Explore",
                          //             style: TextStyle(
                          //               color: Colors.white,
                          //               fontSize: 18,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //           ),
                          //           Icon(Icons.arrow_forward_rounded,
                          //               color: Colors.white),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // )


                        ],
                      )),
                ),
              );
            }

          return Container();

        } ,
          listener: (context,state){
          if(state is UserNotLoginedMessageState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(
                  'Login failed !')),
            );
          }
          },
        )
      ),
    );
  }
}
