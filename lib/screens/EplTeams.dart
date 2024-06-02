import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Classes/EplTeam.dart';
import 'navbar.dart';

class EPLTeams extends StatefulWidget {
  const EPLTeams({Key? key, required this.title}) : super(key: key);
  final String title;

  get team => null;
  

  @override
  State<EPLTeams> createState() => _EPLTeamsState();
}

class _EPLTeamsState extends State<EPLTeams> {
  bool _showSearchField = false; // State variable for showing search field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26, // Set background color of Scaffold
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Change color here
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
        title: _showSearchField
            ? SearchField()
            : null, // Show search field if _showSearchField is true
      ),
      body: SingleChildScrollView(
        // Set background color here
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(), // Ensure scrolling always enabled
        child: Container(
          color: Colors.black54,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${widget.team.name}', style: TextStyle(fontSize: 18)),
                    Text('Stadium: ${widget.team.stadium}', style: TextStyle(fontSize: 18)),
                    Text('Formed Year: ${widget.team.formedYear}', style: TextStyle(fontSize: 18)),
                    Text('Sport: ${widget.team.sport}', style: TextStyle(fontSize: 18)),
                    Text('Description: ${widget.team.description}', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.09, // Adjust the height as needed
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.orange,
          tabBackgroundColor: Colors.black,
          gap: 9,
          tabs: [
            GButton(
              icon: Icons.sports_baseball,
              onPressed: () {
                context.go('/');
              },
              text: 'Scores',
            ),
            GButton(
              icon: Icons.favorite,
              onPressed: () {
                context.go('/Favourites');
              },
              text: 'Favourites',
            ),

            GButton(
              icon: Icons.play_circle_fill,
              onPressed: () {
                context.go('/Watch');
              },
              text: 'Watch',
            ),

            GButton(
              icon: Icons.refresh,
              onPressed: () {},
              text: 'Refresh',
            )
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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