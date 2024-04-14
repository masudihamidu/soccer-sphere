import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 10);
  NavBar({Key? key}); // Fix the constructor syntax

  @override
  Widget build(BuildContext context) {
    Color transparentColor = const Color.fromRGBO(255, 255, 255, 0.3);

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        color: transparentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () {

              },
              child: buildMenuItem(text: 'About', icon: Icons.info_outline),
            ),
            GestureDetector(
              onTap: () {

              },
              child:
              buildMenuItem(text: 'Setting account', icon: Icons.settings),
            ),

            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the drawer
              },

              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Close', style: TextStyle(color: Colors.black)),
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                      child: Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
  }) {
    const color = Colors.black;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: const TextStyle(color: color),
      ),
    );
  }
}
