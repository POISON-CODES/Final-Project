import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  ? FloatingActionButton(
                      isExtended: true,
                      shape: CircleBorder(),
                      onPressed: () {},
                      child: Icon(CupertinoIcons.plus),
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
                ]),
          ),
        );
      },
    );
  }
}
