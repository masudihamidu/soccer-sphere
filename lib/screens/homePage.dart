import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import '../Classes/Player.dart';
import '../Classes/Team.dart';
import 'NavBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showSearchField = false;
  CarouselController buttonCarouselController = CarouselController();
  late Future<List<Team>> futureTeams;

  @override
  void initState() {
    super.initState();
    futureTeams = fetchTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _showSearchField = true;
              });
            },
          ),
        ],
        title: _showSearchField ? SearchField() : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: Colors.black54,
          child: Column(
            children: [
              const Row(
                children: [
                  Text("Leagues", style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_drop_down_outlined, color: Colors.white, size: 40),
                ],
              ),
              FutureBuilder<List<Team>>(
                future: futureTeams,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No teams found'));
                  } else {
                    return CarouselSlider(
                      options: CarouselOptions(height: 180.0), // Remove height property
                      items: snapshot.data!.map((team) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(color: Colors.black),
                              child: Column(
                                children: [
                                  Expanded( // Wrap the Image.network with Expanded
                                    child: Image.network(team.strStadiumThumb, fit: BoxFit.cover),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );

                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.09,
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.orange,
          tabBackgroundColor: Colors.black,
          gap: 9,
          tabs: [
            const GButton(
              icon: Icons.sports_baseball,
              text: 'Scores',
            ),
            GButton(
              onPressed: () {
                context.go('/Favourites');
              },
              icon: Icons.favorite,
              text: 'Favourites',
            ),
            GButton(
              onPressed: () {
                context.go('/Watch');
              },
              icon: Icons.play_circle_fill,
              text: 'Watch',
            ),
            GButton(
              icon: Icons.refresh,
              onPressed: () {},
              text: 'Refresh',
            ),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

// Example fetchTeams function
Future<List<Team>> fetchTeams() async {
  final response = await http.get(Uri.parse('https://www.thesportsdb.com/api/v1/json/3/searchteams.php?t=Barcelona'));

  if (response.statusCode == 200) {
    final List<dynamic> teamsJson = jsonDecode(response.body)['teams'];
    return teamsJson.map((json) => Team.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load teams');
  }
}
