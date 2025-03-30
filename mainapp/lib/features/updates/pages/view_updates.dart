import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/constants/constants.dart' show Priority;
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/updates/cubit/update_cubit.dart';

class ViewUpdatesPage extends StatefulWidget {
  final String companyId;

  static MaterialPageRoute route(String companyId) => MaterialPageRoute(
        builder: (context) => ViewUpdatesPage(companyId: companyId),
      );

  const ViewUpdatesPage({super.key, required this.companyId});

  @override
  State<ViewUpdatesPage> createState() => _ViewUpdatesPageState();
}

class _ViewUpdatesPageState extends State<ViewUpdatesPage> {
  @override
  void initState() {
    super.initState();
    context.read<UpdateCubit>().getUpdatesByCompany(widget.companyId);
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.high:
        return Colors.red;
      case Priority.medium:
        return Colors.orange;
      case Priority.low:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Updates",
      ),
      body: BlocBuilder<UpdateCubit, UpdateState>(
        builder: (context, state) {
          if (state is UpdateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UpdateError) {
            return Center(child: Text(state.error));
          } else if (state is UpdatesLoaded) {
            if (state.updates.isEmpty) {
              return const Center(
                child: Text('No updates available'),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.updates.length,
              itemBuilder: (context, index) {
                final update = state.updates[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(update.update),
                    subtitle: Text(
                      'Priority: ${update.priority.name.toUpperCase()}',
                      style: TextStyle(
                        color: _getPriorityColor(update.priority),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Update'),
                            content: const Text(
                              'Are you sure you want to delete this update?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<UpdateCubit>()
                                      .deleteUpdate(update.id);
                                  Navigator.pop(context);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No updates available'));
        },
      ),
    );
  }
}
