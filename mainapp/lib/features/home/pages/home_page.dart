import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mainapp/constants/enums.dart';
import 'package:mainapp/features/auth/cubit/auth_cubit.dart';
import 'package:mainapp/features/home/pages/tabs/home_page_tab.dart';
import 'package:mainapp/features/home/pages/tabs/search_page_tab.dart';
import 'package:mainapp/features/home/pages/tabs/settings_page_tab.dart';

class HomePage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton:
              (state is AuthLogin && state.user.position == Position.admin)
                  // ? FloatingActionButton(
                  //     isExtended: true,
                  //     shape: CircleBorder(),
                  //     onPressed: () {},
                  //     child: Icon(CupertinoIcons.plus),
                  //   )
                  ? SpeedDial(
                      spaceBetweenChildren: 10,
                      spacing: 10,
                      overlayOpacity: 0,
                      icon: Icons.add,
                      animatedIconTheme: IconThemeData(size: 22),
                      backgroundColor: Colors.white,
                      visible: true,
                      curve: Curves.ease,
                      children: [
                        SpeedDialChild(
                          child: Icon(Icons.description),
                          onTap: () {},
                          label: 'Create a new Form',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.0),
                        ),
                        SpeedDialChild(
                          child: Icon(Icons.edit_note),
                          onTap: () {},
                          label: 'Create an Update',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.0),
                        ),
                        // FAB 2
                        SpeedDialChild(
                          child: Icon(Icons.business),
                          onTap: () {},
                          label: 'Create a new Company',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.0),
                        )
                      ],
                    )
                  : null,
          body: (_selectedPage == 0)
              ? HomePageTab()
              : (_selectedPage == 1)
                  ? SearchPageTab()
                  : SettingsPageTab(),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 15),
            child: GNav(
              onTabChange: (value) => setState(() {
                _selectedPage = value;
              }),
              gap: 5,
              haptic: true,
              activeColor: Colors.white,
              selectedIndex: _selectedPage,
              tabBackgroundColor: Colors.black,
              tabActiveBorder: Border.all(),
              tabBorderRadius: 100,
              textSize: 20,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              tabs: [
                GButton(
                  icon: CupertinoIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: CupertinoIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: CupertinoIcons.gear,
                  text: 'Settings',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
