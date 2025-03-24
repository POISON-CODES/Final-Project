import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/configurations/cubit/configuration_cubit.dart';
import 'package:mainapp/features/configurations/pages/configuration_detail.dart';
import 'package:mainapp/features/configurations/pages/create_configuration.dart';

class ChangeConfiguration extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const ChangeConfiguration(),
      );

  const ChangeConfiguration({super.key});

  @override
  State<ChangeConfiguration> createState() => _ChangeConfigurationState();
}

class _ChangeConfigurationState extends State<ChangeConfiguration> {
  @override
  void initState() {
    super.initState();
    // Fetch all configurations when the page loads
    context.read<ConfigurationCubit>().getAllConfigurations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0, right: 20),
        child: customFloatingActionButton(
          onPress: () =>
              Navigator.of(context).push(CreateConfiguration.route()),
          context: context,
          children: [
            CustomFABChild(
                label: "Create Configuration",
                onTap: () =>
                    Navigator.of(context).push(CreateConfiguration.route()),
                icon: Icon(Icons.add)),
            CustomFABChild(
              label: "Refresh",
              onTap: () {
                context.read<ConfigurationCubit>().getAllConfigurations();
              },
              icon: Icon(Icons.refresh),
            ),
            CustomFABChild(
              label: "Coming Soon",
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Samajh nahi aara Coming Soon Bola toh"),
                ),
              ),
              icon: Icon(Icons.more_horiz),
            )
          ],
          mainIcon: Icons.add,
        ),
      ),
      appBar: CustomAppBar(title: "Change App Configurations"),
      body: BlocConsumer<ConfigurationCubit, ConfigurationState>(
        listener: (context, state) {
          if (state is ConfigurationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is ConfigurationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ConfigurationsLoaded) {
            if (state.configurations.isEmpty) {
              return EmptyConfigurationState(
                onTap: () =>
                    Navigator.of(context).push(CreateConfiguration.route()),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ConfigurationCubit>().getAllConfigurations();
              },
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 100),
                itemCount: state.configurations.length,
                itemBuilder: (context, index) {
                  final config = state.configurations[index];
                  return ConfigurationCard(
                    configuration: config,
                    onTap: () {
                      Navigator.of(context).push(
                        ConfigurationDetailPage.route(config),
                      );
                    },
                    onEdit: () {
                      Navigator.of(context).push(
                        CreateConfiguration.routeWithData(config),
                      );
                    },
                    onDelete: () {
                      _showDeleteConfirmation(context, config.id);
                    },
                  );
                },
              ),
            );
          } else if (state is ConfigurationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ConfigurationCubit>().getAllConfigurations();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Initial state or other states
          return const Center(
            child: Text('Select an action to get started'),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String configId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Configuration'),
        content:
            const Text('Are you sure you want to delete this configuration?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Call delete method
              context.read<ConfigurationCubit>().deleteConfiguration(configId);
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
