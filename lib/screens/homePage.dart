import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'NavBar.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showSearchField = false; // State variable for showing search field
  CarouselController buttonCarouselController = CarouselController();

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
              Row(
                children: [
                  Text("Scores", style: TextStyle(color: Colors.white, fontSize: 20),),
                  Icon(Icons.arrow_drop_down_outlined, color: Colors.white, size: 40,)

                ],
              ),

              CarouselSlider(
                options: CarouselOptions(height: 150.0),
                items: [1,2,3,4,5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber
                          ),
                          child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                      );
                    },
                  );
                }).toList(),
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
            const GButton(
              icon: Icons.sports_baseball,
              text: 'Scores',
            ),
             GButton(
              onPressed: (){
                context.go('/Favourites');
              },
              icon: Icons.favorite,
              text: 'Favourites',
            ),

             GButton(
               onPressed: (){
                 context.go('/Watch');
               },
              icon: Icons.play_circle_fill,
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
