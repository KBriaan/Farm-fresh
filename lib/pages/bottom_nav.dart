import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:soko_fresh/pages/home.dart';
import 'package:soko_fresh/pages/search.dart';
import 'package:soko_fresh/pages/profile.dart';
import 'package:soko_fresh/pages/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homepage;
  late SearchPage _searchPage;
    

  late Profile profilepage;
  
  late Wallet wallet;
  @override
  void initState() {
    homepage =const Home();
    profilepage = const Profile();
    _searchPage=const SearchPage();
    wallet = const Wallet();
    pages = [homepage, _searchPage,  wallet, profilepage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: const Duration(milliseconds:500 ),
        onTap: (int index) {
          setState(() {
            currentTabIndex=index;
          });
        },
        items: const [
        Icon(
          Icons.home_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.search_off_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.wallet_outlined,
          color: Colors.white,
        ),
        Icon(
          Icons.person_outlined,
          color: Colors.white,
        )
      ]),
      body: pages[currentTabIndex]
    );
  }
}
