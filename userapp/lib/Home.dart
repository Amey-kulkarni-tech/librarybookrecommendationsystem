import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:userapp/HomeBloc/home_screen_bloc.dart';
import 'package:userapp/LoginScreen/LoginScreen.dart';
import 'package:userapp/model/bookModel.dart';
import  'package:speech_to_text/speech_to_text.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc homeScreenBloc = HomeScreenBloc();

  TextEditingController searchbarcontroller=TextEditingController();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';


  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }
  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      searchbarcontroller.text=_lastWords;
    });
  }



  @override
  Widget build(BuildContext context) {
    int flag=1;
   // TextEditingController editingController= TextEditingController();
    List<Book> suggestion=[];
    List<Book> books=[];
    return BlocProvider(
      create: (context) => homeScreenBloc..add(LoadBookDataEvent()),
      child: Scaffold(
        backgroundColor: Color(0xffF7EBE1),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Library"),
          backgroundColor: Color(0xFF213333),
          actions: [
            IconButton(onPressed: (){
              homeScreenBloc.add(LoadBookDataEvent());
            }, icon: Icon(Icons.refresh)),
             IconButton(onPressed:  _speechToText.isNotListening ? _startListening : _stopListening

            // (){
            //       searchbarcontroller.text="hello";
            //
            //   //homeScreenBloc.add(LoadBookDataEvent());
             , icon: Icon(Icons.mic))
          ],
        ),
        drawer: NavBar(),
        body: Container(
         padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller:searchbarcontroller,
                  onChanged: (value) {
                    print("in change");
                    if(books.isNotEmpty)
                    {
                      homeScreenBloc.add(SearchBookEvent(books,suggestion,value));
                    }
                  },
                  onSubmitted: (value){
                    print("in change");
                    if(books.isNotEmpty)
                    {
                      homeScreenBloc.add(SearchBookEvent(books,suggestion,value));
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: BlocConsumer<HomeScreenBloc, HomeScreenState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {

                        if(state is HomeScreenInitial)
                          {
                            return Center(
                              child:CircularProgressIndicator()
                            );
                          }
                        else if(state is LoadHomeDataErrorState)
                          {

                          }
                        else if(state is LoadHomeDataState)
                          {
                            if(flag==1)
                            {
                              books=state.book;
                              suggestion=state.suggestions;
                              flag=2;
                            }

                            List<Widget> sug=[];
                            for(int i=0;i<state.suggestions.length;i++)
                              {
                                if(i==4) break;
                                else if(i==0) {
                                  sug.add(Text("Recommended for you",style: TextStyle(fontWeight: FontWeight.bold),));
                    }
                                sug.add(bookCard(state.suggestions[i]));
                              }
                            List<Widget> bk=[];
                            for(int i=0;i<state.book.length;i++)
                            {
                              bk.add(bookCard(state.book[i]));
                            }

                            return RefreshIndicator(
                              onRefresh: _refreshHomeScreen,
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(left:12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     // RecommendationSection(book: state.suggestions,),
                                     SizedBox(height: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: sug,
                                      ),
                                      SizedBox(height: 10,),
                                      // ListView.builder(
                                      //     itemCount: ct,
                                      //     itemBuilder: (BuildContext context,int index){
                                      //         return BookCard(book: state.suggestions[index]);
                                      //
                                      // }),
                                      Text("All Books",
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.0),),
                                      Column(
                                        children: bk,
                                      )
                                      // ListView.builder(
                                      //     itemCount:  state.book.length,
                                      //     itemBuilder: (BuildContext context,int index){
                                      //       return BookCard(book: state.book[index]);
                                      //
                                      //     }),

                                    ],
                                  ),
                                ),
                              ),
                            );



                          }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshHomeScreen() => Future.delayed(Duration(seconds: 1), () {
    homeScreenBloc.add(LoadBookDataEvent());
  });

  Widget bookCard(Book book)
  {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.only(top:10.0,right:5.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(book.bookName.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),),
            subtitle: Text("author: "+book.authorName.toLowerCase()),
            trailing: IconButton(
              icon: Icon(
                book.isliked==1 ? Icons.favorite : Icons.favorite_border,
                color: book.isliked==1 ? Colors.red : null,
              ),
              onPressed: () {
                homeScreenBloc.add(BookLikedEvent(book));
                setState(() {
                  if(book.isliked==0)
                    {
                      book.isliked=1;
                    }
                    else if(book.isliked==1)
                      {
                        book.isliked=0;
                      }
                });
              },
            ),
          ),
        ],
      ),
    );
  }


}
//
// class BookCard extends StatelessWidget {
//   final Book book;
//   final HomeScreenBloc bloc;
//   BookCard({required this.book,required this.bloc});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10.0,
//       margin: EdgeInsets.only(top:10.0,right:5.0),
//       child: Column(
//         children: <Widget>[
//           ListTile(
//             title: Text(book.bookName.toUpperCase(),
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18.0,
//               ),),
//             subtitle: Text("author: "+book.authorName.toLowerCase()),
//             trailing: IconButton(
//               icon: Icon(
//                 book.isliked==1 ? Icons.favorite : Icons.favorite_border,
//                 color: book.isliked==1 ? Colors.red : null,
//               ),
//               onPressed: () {
//                 bloc.add(BookLikedEvent(book));
//                  setState(() {
//                   product.isLiked = !product.isLiked;
//                  });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//




class RecommendationSection extends StatefulWidget {
  final List<Book> book;
  const RecommendationSection({required this.book});

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection> {
  @override
  Widget build(BuildContext context) {

    int ct=4;
    if(widget.book.length<4)
      {
        ct=widget.book.length;
      }

    return Container(
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Recommendation for you",style: TextStyle(fontWeight: FontWeight.bold),),


          // GridView.count(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 4.0,
          //     mainAxisSpacing: 8.0,
          //     children:List.generate (ct,(int index){
          //       return Text("hello all");
          //       // return Card(
          //       //   elevation: 4.0,
          //       //   child: Column(
          //       //     mainAxisAlignment: MainAxisAlignment.center,
          //       //     children: [
          //       //       // Image.asset(
          //       //       //   ,
          //       //       //   height: 100.0,
          //       //       // ),
          //       //       SizedBox(height: 8.0),
          //       //       Text(
          //       //         widget.book[index].bookName,
          //       //         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          //       //       ),
          //       //       SizedBox(height: 4.0),
          //       //       Text(
          //       //         widget.book[index].authorName,
          //       //         style: TextStyle(fontSize: 14.0),
          //       //       ),
          //       //     ],
          //       //   ),
          //       // );
          //       // return Card(
          //             //   elevation: 45.0,
          //             //   child: Padding(
          //             //     padding: const EdgeInsets.all(8.0),
          //             //     child: Column(
          //             //       children: [
          //             //         Text(widget.book[index].bookName),
          //             //         Text(widget.book[index].authorName),
          //             //       ],
          //             //     ),
          //             //   ),
          //             // );
          //
          //     }))
          
        ],
      ),
    );
  }
}






class NavBar extends StatefulWidget {

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String studid = '';
  String name = "";
  late SharedPreferences prefs;
  void getData() async
  {
     prefs= await SharedPreferences.getInstance();
    setState(() {
      studid = prefs.getString("studid")!;
      name = prefs.getString("name")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(studid),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/studimg.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/bgimg.jpg',)),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.favorite),
          //   title: Text('Favorites'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text('Friends'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: Icon(Icons.share),
          //   title: Text('Share'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: Icon(Icons.notifications),
          //   title: Text('Request'),
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: Icon(Icons.description),
          //   title: Text('Policies'),
          //   onTap: () => null,
          // ),
          Divider(),
          ListTile(
            title: Text('Sign Out'),
            leading: Icon(Icons.exit_to_app),
            onTap: (){
                prefs.remove("studid");
                Navigator.of(context).
                pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen())
                );
          }
          ),
        ],
      ),
    );
  }
}
