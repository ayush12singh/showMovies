import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:book_movie/Get_Movies.dart';
import 'package:book_movie/Model.dart';

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable, unused_element, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, non_constant_identifier_names

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Movie',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var popular_movies = <MoviesModel>[];
  var top_movies = <MoviesModel>[];
  var upcoming_movies = <MoviesModel>[];

  bool load = true;
  @override
  void initState() {
    super.initState();
    gm();
  }

  void gm() async {
    Get_movies movies = Get_movies();

    await movies.getPMovies();
    await movies.getTMovies();
    await movies.getUMovies();
    popular_movies = movies.pmovies;
    top_movies = movies.tmovies;
    upcoming_movies = movies.umovies;
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return load == true
        ? Center(child: CircularProgressIndicator(color: Colors.blue))
        : DefaultTabController(
            length: 3,
            child: Scaffold(
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(color: Colors.black),
                      child: Text(
                        "BookMovies",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    ListTile(
                      title: Text("Movies"),
                    ),
                    ListTile(
                      title: Text("Tv Shows"),
                    )
                  ],
                ),
              ),
              appBar: AppBar(
                title: Text("BookMovies",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: Colors.black,
                actions: const [
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  )
                ],
                bottom: const TabBar(
                  indicatorColor: Colors.lightBlue,
                  tabs: [
                    Tab(
                      child: Text(
                        "POPULAR",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "TOP-RATED",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text("UPCOMING",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              body: TabBarView(children: [
                GridView.builder(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  itemCount: popular_movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent:
                          (orientation == Orientation.portrait) ? 210 : 400,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1 / 5,
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 3 : 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Showmovie(
                        originaltitle: popular_movies[index].originaltitle,
                        originalposter: popular_movies[index].originalposter);
                  },
                ),
                GridView.builder(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  itemCount: top_movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent:
                          (orientation == Orientation.portrait) ? 210 : 400,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1 / 5,
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 3 : 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Showmovie(
                        originaltitle: top_movies[index].originaltitle,
                        originalposter: top_movies[index].originalposter);
                  },
                ),
                GridView.builder(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  itemCount: upcoming_movies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent:
                          (orientation == Orientation.portrait) ? 210 : 400,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1 / 5,
                      crossAxisCount:
                          (orientation == Orientation.portrait) ? 3 : 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Showmovie(
                        originaltitle: upcoming_movies[index].originaltitle,
                        originalposter: upcoming_movies[index].originalposter);
                  },
                ),
              ]),
            ),
          );
  }
}

class Showmovie extends StatelessWidget {
  final String originaltitle;
  final String originalposter;

  Showmovie({required this.originaltitle, required this.originalposter});

  @override
  Widget build(BuildContext context) {
   
    final orientation = MediaQuery.of(context).orientation;
    double size = (orientation == Orientation.portrait) ? 10 : 16;
    return Container(
      child: Column(
        children: [
          Image.network("https://www.themoviedb.org/t/p/w600_and_h900_bestv2" +
              originalposter),
          SizedBox(
            height: 3,
          ),
          Text(
            originaltitle,
            style: TextStyle(
                fontSize: size, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
