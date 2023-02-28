import 'package:amazon_app/views/buyers/nav_screen/account_screen.dart';
import 'package:amazon_app/views/buyers/nav_screen/cart_screen.dart';
import 'package:amazon_app/views/buyers/nav_screen/category_screen.dart';
import 'package:amazon_app/views/buyers/nav_screen/home_screen.dart';
import 'package:amazon_app/views/buyers/nav_screen/search_screen.dart';
import 'package:amazon_app/views/buyers/nav_screen/store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    SearchScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value){
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow.shade900,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
              ),
              label: 'ANA SAYFA'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/explore.svg',
                width: 20,
              ),
              label: 'KATEGORİ'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/shop.svg',
                width: 20,
              ),
              label: 'MAĞAZA'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/cart.svg',
                width: 20,
              ),
              label: 'KART'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 20,
              ),
              label: 'ARAMA'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/account.svg',
                width: 20,
              ),
              label: 'HESAP')
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
