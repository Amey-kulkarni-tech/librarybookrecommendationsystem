import 'package:LRA/bookscreen/bookdetailBloc/book_detail_screen_bloc.dart';
import 'package:LRA/models/bookModel.dart';
import 'package:LRA/models/studentModel.dart';
import 'package:LRA/studentscreen/studentdetailBloc/studentdetailscreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({Key? key}) : super(key: key);

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  int flag=1;
  final BookDetailScreenBloc bookdetailBloc=BookDetailScreenBloc();
  TextEditingController editingController = TextEditingController();
  List<Book> items=[];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bookdetailBloc..add(BookDetailLoadingEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text("Books in Library"),),
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
                      bookdetailBloc.add(BookdetailSearchBarEvent(items,value));
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
              BlocConsumer<BookDetailScreenBloc,BookDetailScreenState>(
                  builder:(context,state){
                    if(state is BookDetailScreenInitial)
                    {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if(state is BookdetailErrorState)
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
                              "Check Network. can't able to load Books ",
                              style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      );
                    }
                    else if(state is BookdetailLoadedState)
                    {
                      if(flag==1)
                      {
                        items=state.books;
                        flag=2;
                      }
                      if(state.books.length==0)
                      {
                        return Center(
                          child: Text("No Book Found to Display"),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                            itemCount: state.books.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  TextEditingController bookPriceController=TextEditingController();
                                  TextEditingController authorNameController=TextEditingController();
                                  TextEditingController bookNameController=TextEditingController();
                                  showBottomSheet(context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top:Radius.circular(25.0)),
                                      ) ,

                                      backgroundColor: Colors.white,
                                      builder: (BuildContext context){
                                        bookNameController.text=state.books[index].bookName;
                                        authorNameController.text=state.books[index].authorName;
                                        bookPriceController.text=state.books[index].bookPrice;
                                        return SizedBox(
                                          height: 0.7 * MediaQuery.of(context).size.height,
                                          child: SingleChildScrollView(
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
                                                              controller: bookNameController,
                                                              decoration: InputDecoration(
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                                border: OutlineInputBorder(),
                                                                labelText: 'Book Name',
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
                                                              controller: authorNameController,
                                                              decoration: InputDecoration(
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                                border: OutlineInputBorder(),
                                                                labelText: 'Author Name',
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
                                                              controller: bookPriceController,
                                                              decoration: InputDecoration(
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                                border: OutlineInputBorder(),
                                                                labelText: 'Price',
                                                                hintText: 'Enter Student ID',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                       Wrap(
                                                              spacing: 6.0,
                                                              runSpacing: 6.0,
                                                              children: List.generate(state.books[index].taglist.length,
                                                                      (ind) => _buildChip(state.books[index].taglist[ind].tagname, Colors.greenAccent))
                                                              // children: <Widget>[
                                                              // _buildChip('Gamer', Color(0xFFff6666)),
                                                              // _buildChip('Hacker', Color(0xFF007f5c)),
                                                              // _buildChip('Developer', Color(0xFF5f65d3)),
                                                              // _buildChip('Racer', Color(0xFF19ca21)),
                                                              // _buildChip('Traveller', Color(0xFF60230b)),
                                                              // ],
                                                       ),



                                                        // Container(
                                                        //   child:  Padding(
                                                        //     padding: EdgeInsets.all(15),
                                                        //     child: TextField(
                                                        //       readOnly: true,
                                                        //       textAlign: TextAlign.center,
                                                        //       controller: mobileController,
                                                        //       decoration: InputDecoration(
                                                        //         filled: true,
                                                        //         fillColor: Colors.white,
                                                        //         border: OutlineInputBorder(),
                                                        //         labelText: 'Mobile Number',
                                                        //         hintText: 'Enter Mobile no',
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        Container(
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(15.0),
                                                            child: ElevatedButton(
                                                              child: Text(
                                                                'Delete Book',
                                                                style: TextStyle(
                                                                    color: Colors.white, fontSize: 22),
                                                              ),
                                                              onPressed: (){
                                                                bookdetailBloc.add(BookdetailDeleteEvent(state.books[index]));
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
                                          ),
                                        );
                                      });
                                },
                                child: Card(
                                    child: ListTile(
                                        title: Text(state.books[index].bookName+" "),
                                        subtitle: Text(state.books[index].authorName),
                                        leading: CircleAvatar(
                                            backgroundImage:AssetImage("assets/bookicon.png")
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
                    if(state is BookdetailDeleteState)
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

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(label[0].toUpperCase()),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }



}


