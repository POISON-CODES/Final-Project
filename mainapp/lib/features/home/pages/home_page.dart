// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mainapp/features/auth/cubit/auth_cubit.dart';
import 'package:mainapp/features/companies/pages/company_pages.dart';
import 'package:mainapp/features/configurations/pages/change_configuration.dart';
import 'package:mainapp/features/forms/page/form_pages.dart';
import 'package:mainapp/features/home/pages/tabs/tabs.dart';
import 'package:mainapp/features/updates/pages/create_update.dart';

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
        final bool isAdminOrCoordinator = state is AuthAdminAuthenticated ||
            state is AuthCoordinatorAuthenticated;

        // Define base tabs that are visible to all users
        final List<GButton> baseTabs = [
          const GButton(
            icon: CupertinoIcons.building_2_fill,
            text: 'Companies',
          ),
          const GButton(
            icon: CupertinoIcons.person_2_fill,
            text: 'Users',
          ),
          if (isAdminOrCoordinator) ...[
            const GButton(
              icon: CupertinoIcons.doc_text,
              text: 'Requests',
            ),
            const GButton(
              icon: CupertinoIcons.chart_bar,
              text: 'Stats',
            ),
          ],
          const GButton(
            icon: CupertinoIcons.gear,
            text: 'Settings',
          ),
        ];

        return Scaffold(
          floatingActionButton: (state is AuthAdminAuthenticated)
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
                          onTap: () => Navigator.of(context)
                              .push(CreateUpdatePage.route()),
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
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<AuthCubit>().checkAuthStatus();
            },
            child: SafeArea(
              child: Container(
                  child: (_selectedPage == 0)
                      ? const CompaniesPageTab()
                      : (_selectedPage == 1)
                          ? const UsersPageTab()
                          : (_selectedPage == 2)
                              ? isAdminOrCoordinator
                                  ? const RequestsPageTab()
                                  : const SettingsPageTab()
                              : (_selectedPage == 3)
                                  ? isAdminOrCoordinator
                                      ? const StatsPageTab()
                                      : const SettingsPageTab()
                                  : const SettingsPageTab()),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 15),
            child: GNav(
              onTabChange: (value) {
                // Adjust the selected page index based on user role
                setState(() {
                  if (!isAdminOrCoordinator && value >= 2) {
                    // For regular users, skip Requests and Stats tabs
                    _selectedPage = value + 2;
                  } else {
                    _selectedPage = value;
                  }
                });
              },
              gap: 5,
              haptic: true,
              activeColor: Colors.white,
              selectedIndex: isAdminOrCoordinator
                  ? _selectedPage
                  : _selectedPage >= 2
                      ? _selectedPage - 2
                      : _selectedPage,
              tabBackgroundColor: Colors.black,
              tabActiveBorder: Border.all(),
              tabBorderRadius: 100,
              textSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              tabs: baseTabs,
            ),
          ),
        );
      },
    );
  }
}
