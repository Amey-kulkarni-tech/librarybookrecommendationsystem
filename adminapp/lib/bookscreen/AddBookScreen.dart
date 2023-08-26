import 'package:LRA/bookscreen/addbookBloc/add_book_screen_bloc.dart';
import 'package:LRA/studentscreen/addstudentBloc/AddStudent_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../models/tagModel.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  AddBookScreenBloc addBookScreenBloc=AddBookScreenBloc();
  final _formkey=GlobalKey<FormState>();
  static List<Tag> Servertags=[];
  List<Tag> finaltag=[];

  @override
  Widget build(BuildContext context) {
    TextEditingController mobileController=TextEditingController();
    TextEditingController studentIDController=TextEditingController();
    TextEditingController lastNameController=TextEditingController();
    TextEditingController firstNameController=TextEditingController();
    return BlocProvider(
      create: (context){
        return addBookScreenBloc..add(AddBookTagLoadEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Book"),
        ),
        body: BlocConsumer<AddBookScreenBloc, AddBookScreenState>(
          listener: (context, state) {
            // TODO: implement listener
            if(state is BookInsertedState)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Book Added Successfully !")),
              );
            }
            if(state is BookNotInsertedState)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Something went wrong.")),
              );
            }

          },
          builder: (context, state) {
            if(state is AddBookScreenInitial)
            {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(state is AddBookTagLoadedState) {
              List<Tag> _selectedTags=[];

              String _selectedValuesJson = 'Nothing to show';
              Servertags=state.tags;
              TextEditingController bookNameController= TextEditingController();
              TextEditingController authorNameController=TextEditingController();
              TextEditingController priceController=TextEditingController();

              return  SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 20.0),
                          //   child: Center(
                          //     child: Container(
                          //       width: 200,
                          //       height: 150,
                          //       //decoration: BoxDecoration(
                          //       //borderRadius: BorderRadius.circular(40),
                          //       //border: Border.all(color: Colors.blueGrey)),
                          //       child: Image.asset('assets/student-logo-removebg-preview.png'),
                          //     ),
                          //   ),
                          // ),




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
                              controller: bookNameController= TextEditingController(),
                              decoration: InputDecoration(
                                  hintText: 'Enter Book Name',
                                  labelText: 'Book Name',
                                  prefixIcon: Icon(
                                    Icons.book,
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

                              controller: authorNameController,
                              decoration: InputDecoration(
                                  hintText: 'Enter Author Name',
                                  labelText: 'Author Name',
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
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Enter Price',
                                  labelText: 'Book Price',
                                  prefixIcon: Icon(
                                    Icons.price_change,
                                    color: Colors.lightBlue,
                                  ),
                                  errorStyle: TextStyle(fontSize: 18.0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(9.0)))),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: TextFormField(
                          //     controller: mobileController,
                          //     validator: MultiValidator([
                          //       RequiredValidator(errorText: 'Enter mobile number'),
                          //
                          //     ]),
                          //     decoration: InputDecoration(
                          //         hintText: 'Mobile',
                          //         labelText: 'Mobile',
                          //         prefixIcon: Icon(
                          //           Icons.phone,
                          //           color: Colors.grey,
                          //         ),
                          //         border: OutlineInputBorder(
                          //             borderSide: BorderSide(color: Colors.red),
                          //             borderRadius:
                          //             BorderRadius.all(Radius.circular(9)))),
                          //   ),
                          // ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlutterTagging<Tag>(
                              initialItems: _selectedTags,
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.green.withAlpha(30),
                                  hintText: 'Search Tags',
                                  labelText: 'Select Tags',
                                ),
                              ),
                              findSuggestions: getTags,
                              additionCallback: (value) {
                                return Tag(
                                  tagname: value,
                                  id: "-1",
                                );
                              },
                              onAdded: (language) {
                                // api calls here, triggered when add to tag button is pressed
                               Servertags.add(language);
                               finaltag.add(language);
                                return language;
                              },
                              configureSuggestion: (lang) {
                                return SuggestionConfiguration(
                                  title: Text(lang.tagname),
                                  additionWidget: Chip(
                                    avatar: Icon(
                                      Icons.add_circle,
                                      color: Colors.white,
                                    ),
                                    label: Text('Add New Tag'),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                              configureChip: (lang) {
                                return ChipConfiguration(
                                  label: Text(lang.tagname),
                                  backgroundColor: Colors.green,
                                  labelStyle: TextStyle(color: Colors.white),
                                  deleteIconColor: Colors.white,
                                );
                              },
                              onChanged: () {
                                // setState(() {
                                //   _selectedValuesJson = _selectedTags
                                //       .map<String>((tag) => '\n${tag.toJson()}')
                                //       .toList()
                                //       .toString();
                                //   _selectedValuesJson =
                                //       _selectedValuesJson.replaceFirst('}]', '}\n]');
                                //     finaltag.add(_selectedTags.first);
                                // });
                                finaltag.add(_selectedTags.first);
                                print("\n\n\n");
                                print(_selectedTags);
                                _selectedTags.forEach((element) {print(element.tagname+" \t");});
                                print(_selectedValuesJson);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
            //               finaltag.isEmpty ? Container() : Container(
            //                 height: 500.0,
            //                 child: ListView.builder(
            //       itemCount: finaltag.length,
            //       itemBuilder: (BuildContext context,int index ){
            //         return ListTile(
            //           title: Text(finaltag[index].tagname),
            //         );
            //
            //   }
            // ),
            //               ),

                          Center(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Container(
                                  // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),
                                  child: ElevatedButton(
                                    child: Text(
                                      'Add Book',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    onPressed: () {
                                      if (finaltag.isNotEmpty) {
                                        print('form submiitted');
                                        addBookScreenBloc.add(InsertBookEvent(bookName: bookNameController.text,authorName: authorNameController.text,bookPrice: priceController.text,tags: finaltag));
                                      //  addStudentBloc.add(AddStudentEnrollEvent(firstName: firstNameController.text, lastName: lastNameController.text, studentId: studentIDController.text, mobileNumber: mobileController.text));
                                      }
                                      else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text(
                                              'Please add tag')),
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

    static Future<List<Tag>> getTags(String query) async {
  await Future.delayed(Duration(milliseconds: 500), null);
  return Servertags.where((tag) => tag.tagname.toLowerCase().contains(query.toLowerCase()))
      .toList();
  }


}
