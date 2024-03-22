import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
          child: Text(
            '',
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.05;
    double paddingSize = MediaQuery.of(context).size.width * 0.03;

    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: BottomAppBar(
          color: Colors.black,
          elevation: 10.0,
          shape: CircularNotchedRectangle(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: NavBarItem(
                    icon: Icons.home,
                    label: 'Home',
                    iconSize: iconSize,
                  ),
                ),
                Expanded(
                  child: NavBarItem(
                    icon: Icons.shopping_cart,
                    label: 'Shop',
                    iconSize: iconSize,
                  ),
                ),
                Expanded(
                  child: NavScannerItem(
                    iconSize: iconSize,
                  ),
                ),
                Expanded(
                  child: NavBarItem(
                    icon: Icons.credit_card,
                    label: 'Order',
                    iconSize: iconSize,
                  ),
                ),
                Expanded(
                  child: NavBarItem(
                    icon: Icons.account_circle,
                    label: 'Profile',
                    iconSize: iconSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final double iconSize;

  NavBarItem({
    required this.icon,
    required this.label,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: iconSize,
            ),
            SizedBox(height: 1.0),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                fontFamily: 'Gilroy',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavScannerItem extends StatelessWidget {
  final double iconSize;

  NavScannerItem({required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(
          Icons.qr_code_scanner,
          color: Colors.black,
          size: iconSize,
        ),
      ),
    );
  }
}
