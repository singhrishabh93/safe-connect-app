import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:safe_connect/screens/HomeScreen/homeScreen.dart';
import 'package:safe_connect/screens/QrScanner/qrScanner.dart';

class bottomNavigationBar extends StatefulWidget {
  @override
  _bottomNavigationBarState createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  int _selectedIndex = 0;

  List<Color> _iconColors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black
  ];

  final List<Widget> _screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _updateIconColors(index);
    });
  }

  void _updateIconColors(int selectedIndex) {
    for (int i = 0; i < _iconColors.length; i++) {
      _iconColors[i] = i == selectedIndex ? Colors.black : Colors.grey;
    }
  }

  Widget _buildIconWithDot(IconData iconData, int index) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(iconData, color: _iconColors[index]),
          onPressed: () => _onItemTapped(index),
        ),
        if (_selectedIndex == index)
          Positioned(
            bottom: 0,
            left: 21.5, // Adjust this value to position the dot as desired
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Show selected screen
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Get.to(() => QRCodeScanner());
        },
        child: Icon(
          Icons.qr_code,
          color: Colors.white,
          size: 35,
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 70, // Reduce the height of the bottom navigation bar
        child: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildIconWithDot(Icons.home, 0),
              _buildIconWithDot(Icons.search, 1),
              _buildIconWithDot(Icons.person, 2),
              _buildIconWithDot(Icons.settings, 3),
            ],
          ),
        ),
      ),
    );
  }
}
