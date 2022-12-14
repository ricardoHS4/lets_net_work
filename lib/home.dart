import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_net_work/discover_page.dart';
import 'package:lets_net_work/host_page.dart';
import 'package:lets_net_work/rewards_page.dart';


class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  final screens = const [
    DiscoverPage(),
    HostPage(),
    RewardsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lets Net-Work!"),
        centerTitle: true,
      ),
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          //indicatorColor: Colors.blue.shade100,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)
          )
        ),
        child: NavigationBar(
          selectedIndex: index,
          height: 60,
          onDestinationSelected: (value) => setState(() {
            index = value;
          }),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.explore_outlined) , selectedIcon: Icon(Icons.explore),label: "Discover"),
            NavigationDestination(icon: Icon(Icons.add_location_alt_outlined), selectedIcon: Icon(Icons.add_location_alt) , label: "Host"),
            NavigationDestination(icon: Icon(CupertinoIcons.gift), selectedIcon: Icon(CupertinoIcons.gift_fill) , label: "Rewards"),
          ],
        ),
      ),
      
    );
  }
}