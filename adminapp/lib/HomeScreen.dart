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
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => homeScreenBloc
    ..add(LoadHomeScreenEvent()),
    child:Scaffold(
    appBar: AppBar(
      centerTitle: true,
    title: Text("LRA  Admin"),
    ),
    body: BlocConsumer<HomeScreenBloc, HomeScreenState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is HomeScreenLoadedState)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Welcome to Library Recommendation App')),
        );
      }

  },
  builder: (context, state) {
        if(state is HomeScreenLoadingState)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        if(state is HomeScreenLoadedState)
        {
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
                  homeScreenBloc.add(HomeScreenMenuClickedEvent(menuIndex: 1,context: context));
                },
                child: Card(
                  elevation: 45.0,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white60,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    height: 100,
                    child: Center(child: Text('Add Student',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {homeScreenBloc.add(HomeScreenMenuClickedEvent(menuIndex: 2,context: context));
                },
                child: Card(
                  elevation: 45.0,
                  color: Colors.white60,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white70,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    height: 100,
                    child: Center(child: Text('Add Book',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap:(){
                  homeScreenBloc.add(HomeScreenMenuClickedEvent(menuIndex: 3,context: context));
                },
                child: Card(

                  elevation: 45.0,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white60,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    height: 100,
                    child: Center(child: Text('Students',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  homeScreenBloc.add(HomeScreenMenuClickedEvent(menuIndex: 4,context: context));
                },
                child: Card(

                  elevation: 45.0,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white60,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const SizedBox(
                    height: 100,
                    child: Center(child: Text('Books',
                      style: TextStyle(fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54),),
                    ),
                  ),
                ),
              ),
            ],
          );

        }
        return Container();

  },
),
    )
    );
  }
}
