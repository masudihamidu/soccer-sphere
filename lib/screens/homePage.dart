import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:provider/provider.dart';
import '../Classes/AppState.dart';
import '../Classes/event.dart';
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
  late Future<List<Event>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = Event.fetchEvents('4328', '2023-2024');
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

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
        title: _showSearchField
            ? const SearchField()
            : const Text(
          'Soccer',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.black54,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Matches", style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_drop_down_outlined, color: Colors.white, size: 40),
                ],
              ),
            ),
            FutureBuilder<List<Event>>(
              future: futureEvents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No matches found'));
                } else {
                  return Expanded(
                    child: GroupListView(
                      sectionsCount: snapshot.data!.length,
                      countOfItemInSection: (int section) {
                        return 1;
                      },
                      itemBuilder: (BuildContext context, IndexPath index) {
                        final event = snapshot.data![index.section];
                        return Card(
                          color: Colors.black,
                          elevation: 8.0,
                          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (event.strHomeTeamBadge != null && event.strHomeTeamBadge.isNotEmpty)
                                      Image.network(event.strHomeTeamBadge, width: 50, height: 50),
                                    const SizedBox(width: 10),
                                    if (event.strAwayTeamBadge != null && event.strAwayTeamBadge.isNotEmpty)
                                      Image.network(event.strAwayTeamBadge, width: 50, height: 50),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(event.strEvent, style: const TextStyle(color: Colors.white)),
                                Text('Time: ${event.strTime}', style: const TextStyle(color: Colors.white70)),
                                Text('Date: ${event.dateEvent}', style: const TextStyle(color: Colors.white70)),
                              ],
                            ),
                          ),
                        );
                      },
                      groupHeaderBuilder: (BuildContext context, int section) {
                        final event = snapshot.data![section];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Text(
                            event.strLeague,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      sectionSeparatorBuilder: (context, section) => const SizedBox(height: 10),
                    ),
                  );
                }
              },
            ),
          ],
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
          selectedIndex: appState.selectedIndex,
          onTabChange: (index) {
            appState.setSelectedIndex(index);
            if (index == 0) {
              context.go('/');
            } else if (index == 1) {
              context.go('/Favourites');
            } else if (index == 2) {
              context.go('/Watch');
            } else if (index == 3) {
              setState(() {
                futureEvents = Event.fetchEvents('4328', '2023-2024');
              });
            }
          },
          tabs: const [
            GButton(
              icon: Icons.sports_baseball,
              text: 'Scores',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favourites',
            ),
            GButton(
              icon: Icons.play_circle_fill,
              text: 'Watch',
            ),
            GButton(
              icon: Icons.refresh,
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
