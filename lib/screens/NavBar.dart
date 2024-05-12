import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        color: Colors.black.withOpacity(0.5), // Use black with 50% opacity
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Change to white for better visibility
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/loginForm("")');
              },
              child: buildMenuItem(text: 'About', icon: Icons.info_outline),
            ),
            GestureDetector(
              onTap: () {
                // Handle onTap for setting account
              },
              child: buildMenuItem(text: 'Setting account', icon: Icons.settings),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the drawer
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Close', style: TextStyle(color: Colors.white)), // Change text color to white
                    Icon(
                      Icons.close,
                      color: Colors.white, // Change icon color to white
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
    return ListTile(
      leading: Icon(icon, color: Colors.white), // Set icon color to white
      title: Text(
        text,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
    );
  }
}
