import 'package:flutter/material.dart';
import 'package:safe_connect/screens/HomeScreen/homeScreen.dart';
import 'package:safe_connect/screens/UserProfile/userProfile.dart';

class bottomNavigationBar extends StatefulWidget {
  const bottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  static List<Widget> _bodyView = <Widget>[
    HomeScreen(),
    Text(
      'Index 1: Business',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Index 2: School',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Index 3: Other',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  Widget _tabItem(Widget child, {bool isSelected = false}) {
    double circleSize = MediaQuery.of(context).size.width *
        0.07; // Adjust the multiplier as needed

    return AnimatedContainer(
      margin: EdgeInsets.all(1),
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 500),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
      padding: EdgeInsets.all(5),
      child: SizedBox(
        width: circleSize,
        height: circleSize,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _icons = [
      Icon(
        Icons.home_outlined,
        size: 30,
      ),
      Icon(
        Icons.explore_outlined,
        size: 30,
      ),
      Icon(
        Icons.qr_code,
        size: 40,
        color: Colors.black,
      ),
      Icon(
        Icons.settings_outlined,
        size: 30,
      ),
      Icon(
        Icons.person_outline,
        size: 30,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: _bodyView.elementAt(_selectedIndex),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  color: Colors.black,
                  child: TabBar(
                    onTap: (x) {
                      setState(() {
                        _selectedIndex = x;
                      });
                    },
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Colors.transparent,
                            width: 0), // Hide the indicator
                      ),
                    ),
                    tabs: [
                      for (int i = 0; i < _icons.length; i++)
                        _tabItem(
                          _icons[i],
                          isSelected: i == _selectedIndex,
                        ),
                    ],
                    controller: _tabController,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: MediaQuery.of(context).size.width / 2 -
                28, // Adjust this value to center the button
            child: FloatingActionButton(
              onPressed: () {
                // Add onPressed functionality for the floating action button
              },
              backgroundColor:
                  Colors.grey.shade400, // Background color for the button
              child: Icon(
                Icons.qr_code,
                size: 40,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
