import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, -2), // Positioned above the nav bar
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api),
            label: 'API Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white, // Text and icon color when selected
        unselectedItemColor:
            Colors.grey[300], // Text and icon color when not selected
        showUnselectedLabels: true, // Show labels for unselected items
        backgroundColor: Colors.transparent, // Transparent to show the gradient
        type: BottomNavigationBarType.fixed, // Ensure all icons are visible
        onTap: onItemTapped,
        selectedFontSize: 14, // Font size for selected item
        unselectedFontSize: 12, // Font size for unselected items
        elevation: 0, // Remove default shadow since custom shadow is applied
      ),
    );
  }
}
