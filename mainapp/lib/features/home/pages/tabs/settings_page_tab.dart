part of 'tabs.dart';

class SettingsPageTab extends StatefulWidget {
  const SettingsPageTab({super.key});

  @override
  State<SettingsPageTab> createState() => _SettingsPageTabState();
}

class _SettingsPageTabState extends State<SettingsPageTab> {
  @override
  void initState() {
    super.initState();
    // Load user's requests when the tab is initialized
    final user = (context.read<AuthCubit>().state as dynamic).user;
    context.read<RequestCubit>().getRequestsByUserId(user.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is! AuthAdminAuthenticated &&
            state is! AuthCoordinatorAuthenticated &&
            state is! AuthStudentAuthenticated) {
          return const Center(child: Text('Please log in to access settings'));
        }

        final user = (state as dynamic).user;

    return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0.8),
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 56),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: Text(
                                user.name[0].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              user.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.email,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(context, 'Account Settings'),
                      BlocBuilder<RequestCubit, RequestState>(
                        builder: (context, requestState) {
                          String subtitle;
                          Color? statusColor;
                          bool isEnabled = true;

                          if (requestState is RequestLoaded) {
                            final masterDataRequest = requestState.requests
                                .where((r) => r.type == RequestType.masterData)
                                .toList();

                            if (masterDataRequest.isNotEmpty) {
                              final request = masterDataRequest.first;
                              switch (request.status) {
                                case RequestStatus.pending:
                                  subtitle = 'Approval pending';
                                  statusColor = Colors.orange;
                                  isEnabled = false;
                                  break;
                                case RequestStatus.approved:
                                  subtitle = 'Already filled';
                                  statusColor = Colors.green;
                                  break;
                                case RequestStatus.rejected:
                                  subtitle = 'Request rejected, try again';
                                  statusColor = Colors.red;
                                  break;
                              }
                            } else {
                              subtitle = 'Fill your profile information';
                              statusColor = Colors.blue;
                            }
                          } else {
                            subtitle = user.masterDataFilled
                                ? 'Update your personal information'
                                : 'Complete your profile information';
                            statusColor = user.masterDataFilled
                                ? Colors.green
                                : Colors.blue;
                          }

                          return _buildSettingsCard(
                            context,
                            title: 'Master Data',
                            subtitle: subtitle,
                            icon: Icons.person_outline,
                            statusColor: statusColor,
                            onTap: isEnabled
                                ? () async {
                                    final navigator = Navigator.of(context);

                                    context.read<RequestCubit>();
                                    final masterDataCubit =
                                        context.read<MasterDataCubit>();

                                    // If there's a rejected request, try to get the master data to pre-fill
                                    if (requestState is RequestLoaded) {
                                      final rejectedRequest = requestState
                                          .requests
                                          .where((r) =>
                                              r.type ==
                                                  RequestType.masterData &&
                                              r.status ==
                                                  RequestStatus.rejected)
                                          .firstOrNull;

                                      if (rejectedRequest != null) {
                                        await masterDataCubit.getMasterDataById(
                                            rejectedRequest.id!);
                                      }
                                    }

                                    navigator.push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterDataFormPage(),
                                      ),
                                    );
                                  }
                                : null,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildSectionTitle(context, 'App Settings'),
                      _buildSettingsCard(
                        context,
                        title: 'Notifications',
                        subtitle: 'Manage your notification preferences',
                        icon: Icons.notifications_outlined,
                        onTap: () {
                          // TODO: Implement notifications settings
                        },
                      ),
                      _buildSettingsCard(
                        context,
                        title: 'Theme',
                        subtitle: 'Change app appearance',
                        icon: Icons.palette_outlined,
                        onTap: () {
                          // TODO: Implement theme settings
                        },
                      ),
                      const SizedBox(height: 24),
                      _buildLogoutButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }

  Widget _buildSettingsCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback? onTap,
    Color? statusColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (statusColor ?? Theme.of(context).primaryColor)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: statusColor ?? Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: statusColor ?? Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              if (statusColor == Colors.green)
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                )
              else if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          context.read<AuthCubit>().signOut();
        },
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
