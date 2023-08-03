import 'package:LRA/homescreen/HomeScreen_event.dart';
import 'package:LRA/homescreen/HomeScreen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'homescreen/HomeScreen_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeScreenBloc()
    ..add(LoadHomeScreenEvent()),
    child:Scaffold(
    appBar: AppBar(
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
        if(state is HomeScreenLoadedState) {
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
                onTap: () {
                  print("got tapped");
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
                onTap: () {
                  print("got tapped");
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
                  print("got tapped");
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
