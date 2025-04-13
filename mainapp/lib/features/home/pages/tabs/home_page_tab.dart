part of 'tabs.dart';

class CompaniesPageTab extends StatefulWidget {
  const CompaniesPageTab({super.key});

  @override
  State<CompaniesPageTab> createState() => _CompaniesPageTabState();
}

class _CompaniesPageTabState extends State<CompaniesPageTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      }
    });
    context.read<CompanyCubit>().getAllCompanies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(index);
    });
  }

  List<CompanyModel> _filterCompaniesByTab(
      List<CompanyModel> companies, int tabIndex) {
    final currentUser = context.read<AuthCubit>().state;
    final String? userId =
        currentUser is AuthStudentAuthenticated ? currentUser.user.id : null;

    switch (tabIndex) {
      case 0: // My List
        return companies
            .where((c) => c.students?.contains(userId) ?? false)
            .toList();

      case 1: // Active
        final now = DateTime.now();
        return companies
            .where((c) => c.deadline != null && c.deadline!.isAfter(now))
            .toList();

      case 2: // Past
        final now = DateTime.now();
        return companies
            .where((c) => c.deadline != null && c.deadline!.isBefore(now))
            .toList();

      case 3: // All
        return List.from(companies);

      default:
        return [];
    }
  }

  Widget _buildCompanyList(
      List<CompanyModel> companies, String emptyMessage, IconData emptyIcon) {
    if (companies.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              emptyIcon,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              emptyMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            TextButton.icon(
              onPressed: () {
                context.read<CompanyCubit>().getAllCompanies();
              },
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text("Refresh"),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: companies.length,
      itemBuilder: (context, index) {
        return CompanyCard(company: companies[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          height: 36,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: _TabButton(
                  label: 'My List',
                  isSelected: _selectedIndex == 0,
                  onTap: () => _handleTabSelection(0),
                ),
              ),
              Expanded(
                child: _TabButton(
                  label: 'Active',
                  isSelected: _selectedIndex == 1,
                  onTap: () => _handleTabSelection(1),
                ),
              ),
              Expanded(
                child: _TabButton(
                  label: 'Past',
                  isSelected: _selectedIndex == 2,
                  onTap: () => _handleTabSelection(2),
                ),
              ),
              Expanded(
                child: _TabButton(
                  label: 'All',
                  isSelected: _selectedIndex == 3,
                  onTap: () => _handleTabSelection(3),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.primaryColor.withOpacity(0.1)),
          ),
          child: BlocBuilder<CompanyCubit, CompanyState>(
            builder: (context, state) {
              if (state is CompaniesLoaded) {
                final now = DateTime.now();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(
                      icon: Icons.star_rounded,
                      label: 'Applied',
                      count: _filterCompaniesByTab(state.companies, 0)
                          .length
                          .toString(),
                      color: Colors.amber,
                    ),
                    _StatItem(
                      icon: Icons.business_center,
                      label: 'Active',
                      count: state.companies
                          .where((c) =>
                              c.deadline != null && c.deadline!.isAfter(now))
                          .length
                          .toString(),
                      color: Colors.blue,
                    ),
                    _StatItem(
                      icon: Icons.history,
                      label: 'Past',
                      count: state.companies
                          .where((c) =>
                              c.deadline != null && c.deadline!.isBefore(now))
                          .length
                          .toString(),
                      color: Colors.grey,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<CompanyCubit, CompanyState>(
            builder: (context, state) {
              if (state is CompanyInitial || state is CompanyLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CompaniesLoaded) {
                return TabBarView(
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCompanyList(
                      _filterCompaniesByTab(state.companies, 0),
                      "You haven't applied to any companies yet",
                      Icons.star_border_rounded,
                    ),
                    _buildCompanyList(
                      _filterCompaniesByTab(state.companies, 1),
                      "No active opportunities available",
                      Icons.business_center_outlined,
                    ),
                    _buildCompanyList(
                      _filterCompaniesByTab(state.companies, 2),
                      "No past companies to show",
                      Icons.history_outlined,
                    ),
                    _buildCompanyList(
                      _filterCompaniesByTab(state.companies, 3),
                      "No companies available",
                      Icons.business_outlined,
                    ),
                  ],
                );
              } else if (state is CompanyError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline,
                          size: 32, color: Colors.red[300]),
                      const SizedBox(height: 8),
                      Text(
                        state.error,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red[700], fontSize: 14),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[600],
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String count;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          count,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
