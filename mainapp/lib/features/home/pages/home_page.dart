// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/features/auth/cubit/auth_cubit.dart';
import 'package:mainapp/features/companies/pages/company_pages.dart';
import 'package:mainapp/features/configurations/pages/change_configuration.dart';
import 'package:mainapp/features/forms/page/form_pages.dart';
import 'package:mainapp/features/home/pages/tabs/tabs.dart';

import '../../../custom/widgets/custom_global_widgets.dart';

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
                  ? customFloatingActionButton(
                      context: context,
                      mainIcon: Icons.add,
                      children: [
                          CustomFABChild(
                              label: 'Create New Form',
                              onTap: () => Navigator.of(context)
                                  .push(CreateFormPage.route()),
                              icon: Icon(Icons.description)),
                          CustomFABChild(
                              label: 'Create Update',
                              onTap: () {},
                              icon: Icon(Icons.edit_note)),
                          CustomFABChild(
                              label: 'Create Company',
                              onTap: () => Navigator.of(context)
                                  .push(CreateNewCompanyPage.route()),
                              icon: Icon(Icons.business)),
                          CustomFABChild(
                              label: 'Update Configuration',
                              onTap: () => Navigator.of(context)
                                  .push(ChangeConfiguration.route()),
                              icon: Icon(Icons.settings)),
                        ])
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
