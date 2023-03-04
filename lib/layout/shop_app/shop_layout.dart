import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:newsapp/layout/shop_app/cubit/cubit.dart';
import 'package:newsapp/layout/shop_app/cubit/states.dart';
import 'package:newsapp/modules/shop_app/Search/search_screen.dart';
import 'package:newsapp/modules/shop_app/login/shop_login_screen.dart';
import 'package:newsapp/shared/constans.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/styles/colors.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        int drawerIndex = 1;
        return Scaffold(
          appBar: NewGradientAppBar(
            title: Text(
              '3nter Store',
            ),
            gradient: LinearGradient(
              colors:
              [
                Colors.grey,
                Colors.black,
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(),
                          ));
                    },
                    icon: Icon(
                      Icons.search,
                    )),
              )
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: GNav(
              tabMargin: EdgeInsets.only(bottom: 7),
              selectedIndex: cubit.currentIndex,
              onTabChange: (index) {
                cubit.ChangeBottomNavIndex(index);
              },
              rippleColor: Colors.grey, // tab button ripple color when pressed
              hoverColor: Colors.grey, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(
                color: Colors.black,
                width: 1,
              ),
              tabBorder: Border.all(
                color: Colors.black54,
                width: 1,
              ),
              tabShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
              ], // tab button shadow
              curve: Curves.easeOutExpo, // tab animation curves
              duration: Duration(milliseconds: 500), // tab animation duration
              gap: 5, // the tab button gap between icon and text
              color: Colors.grey[600], // unselected icon color
              activeColor: Colors.black, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: Colors.purple
                  .withOpacity(0.1), // selected tab background color
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // navigation bar padding
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.apps_rounded,
                  text: 'Categories',
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Favorite',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                )
              ]),
          drawer: CurvedDrawer(
            index: drawerIndex,
            color: Colors.white,
            backgroundColor: Colors.black,
            labelColor: Colors.black54,
            width: 75.0,
            items: [
              DrawerItem(
                icon: Icon(
                  Icons.logout,
                ),
                label: 'Sign Out',
              ),
              DrawerItem(
                  icon: Icon(
                    Icons.message,
                  ),
                  label: "Messages")
            ],
            onTap: (index) {
              drawerIndex = index;
              if (drawerIndex == 0) {
                signOut(context);
              }
            },
          ),
        );
      },
    );
  }
}
