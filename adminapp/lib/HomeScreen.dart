import 'package:LRA/homescreen/HomeScreen_event.dart';
import 'package:LRA/homescreen/HomeScreen_state.dart';
import 'package:LRA/studentscreen/AddStudentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homescreen/HomeScreen_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenBloc homeScreenBloc=HomeScreenBloc();

  @override
  void initState() {
    // TODO: implement initState
    homeScreenBloc.add(LoadHomeScreenEvent());

  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => homeScreenBloc
    ..add(LoadHomeScreenEvent()),
    child:Scaffold(
    appBar: AppBar(
      centerTitle: true,
    title: Text("LRA  Admin"),
    ),
    body: BlocBuilder<HomeScreenBloc,HomeScreenState>(
      builder: (context,state) {
        if(state is HomeScreenLoadingState)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        else if(state is HomeNavigateToAddStudentState)
          {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddStudentScreen()));
          });
          }
        else if(state is HomeScreenLoadedState) {
          return GridView.count(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                 // context.read<HomeScreenBloc>().add(LoadHomeScreenEvent());
                   homeScreenBloc.add(HomeScreenMenuClickedEvent(menuIndex: 1));
                },
                child: Card(
                  color: Color(0xff0077b6),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    height: 100,
                    child: Center(child: Text('Add Student',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {homeScreenBloc.add(HomeScreenMenuClickedEvent(menuIndex: 2));
                },
                child: Card(
                  color: Color(0xff0077b6),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    height: 100,
                    child: Center(child: Text('Add Book',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap:(){
                  homeScreenBloc.add(HomeScreenMenuClickedEvent(menuIndex: 3));
                },
                child: Card(
                  color: Color(0xff0077b6),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    height: 100,
                    child: Center(child: Text('Students',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  homeScreenBloc.add(HomeScreenMenuClickedEvent(menuIndex: 4));
                },
                child: Card(
                  color: Color(0xff0077b6),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    height: 100,
                    child: Center(child: Text('Books',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      }
    ),
    )
    );
  }
}
