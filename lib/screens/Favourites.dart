import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../Classes/Player.dart';
import 'NavBar.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool _showSearchField = false;
  CarouselController buttonCarouselController = CarouselController();
  late Future<List<Player>> futurePlayers;


  @override
  void initState() {
    super.initState();
    futurePlayers = Player.fetchPlayerData('messi');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
            ? const SearchField()
            : null,
      ),
      body: SingleChildScrollView(
        // Set background color here
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: Colors.black54,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Favourites",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Icon(Icons.arrow_drop_down_outlined, color: Colors.white, size: 40,),
                  ],
                ),
              ),

              FutureBuilder<List<Player>>(
                future: futurePlayers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.orange,));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No players found'));
                  } else {
                    // Filter players with non-null images
                    final playersWithImages = snapshot.data!.where((player) => player.strThumb != null && player.strThumb.isNotEmpty).toList();

                    // Display only the first 8 players
                    final playersToShow = playersWithImages.length > 8 ? playersWithImages.sublist(0, 8) : playersWithImages;

                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 250.0,
                        autoPlay: true, // Enable auto play
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                      ),
                      items: playersToShow.map((player) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(color: Colors.black),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(player.strThumb!, fit: BoxFit.cover),
                                  ),
                                  Text(player.strPlayer, style: const TextStyle(fontSize: 16.0, color: Colors.white)),
                                  Text(player.strTeam, style: const TextStyle(fontSize: 12.0, color: Colors.white70)),
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
            GButton(
              icon: Icons.sports_baseball,
              onPressed: () {
                context.go('/');
              },
              text: 'Scores',
            ),
            const GButton(
              icon: Icons.favorite,
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
            ),
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
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
