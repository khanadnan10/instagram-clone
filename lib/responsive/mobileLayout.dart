import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/pages/add_post_screen.dart';
import 'package:instagram_clone/pages/home_screen.dart';
import 'package:instagram_clone/provider/bottomNavBar_provider.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = const [
      HomeScreen(),
      Center(child: Text('Search')),
      AddPostscreen(),
      Center(child: Text('Reels')),
      Text('Profile'),
    ];
    final BottomNavbarProvider bottomNavbarProvider =
        context.watch<BottomNavbarProvider>();

    int idx = bottomNavbarProvider.index;

    bool isUpload = false;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: mobileBackgroundColor,
            selectedItemColor: primaryColor,
            unselectedItemColor: secondaryColor,
            iconSize: 27.0,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomAddIcon(
                  isUpload: idx != 2 ? isUpload : isUpload = true,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/instagram-reels.svg',
                  height: 27.0,
                  width: 27.0,
                  fit: BoxFit.fill,
                  color: secondaryColor,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/images/instagram-reels-white.svg',
                  height: 27.0,
                  width: 27.0,
                  fit: BoxFit.fill,
                  color: primaryColor,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                label: '',
              ),
            ],
            currentIndex: bottomNavbarProvider.index,
            onTap: (value) {
              bottomNavbarProvider.updateScreen(value);
              print(screens[value]);
            }),
        body: screens[idx],
      ),
    );
  }
}
