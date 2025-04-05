part of 'tabs.dart';

class SettingsPageTab extends StatelessWidget {
  const SettingsPageTab({super.key});

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
          appBar: CustomAppBar(
            title: "Settings",
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFormButton(
                  context,
                  title: 'Fill Master Data',
                  icon: Icons.data_object,
                  isFilled: user.masterDataFilled,
                  onTap: () {
                    // TODO: Navigate to master data form
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Master data form coming soon!'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _buildFormButton(
                  context,
                  title: 'Fill Default Form',
                  icon: Icons.description,
                  isFilled: user.defaultFormFilled,
                  onTap: () {
                    // TODO: Navigate to default form
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Default form coming soon!'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isFilled,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple[400]!,
                Colors.deepPurple[700]!,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
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
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          isFilled ? 'Completed' : 'Not Completed',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                        if (isFilled) ...[
                          const SizedBox(width: 8),
                          Icon(
                            Icons.check_circle,
                            color: Colors.green[300],
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isFilled ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isFilled) ...[
                      const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      isFilled ? 'Done' : 'Fill Now',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
