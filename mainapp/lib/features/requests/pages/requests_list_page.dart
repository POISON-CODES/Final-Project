import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/custom/widgets/custom_global_widgets.dart';
import 'package:mainapp/features/requests/cubit/request_cubit.dart';
import 'package:mainapp/features/requests/pages/request_detail_page.dart';
import 'package:mainapp/models/models.dart';
import 'package:mainapp/constants/constants.dart';

class RequestsListPage extends StatelessWidget {
  const RequestsListPage({super.key});

  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const RequestsListPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Requests'),
      body: BlocBuilder<RequestCubit, RequestState>(
        builder: (context, state) {
          if (state is RequestLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RequestError) {
            return Center(child: Text(state.message));
          } else if (state is RequestLoaded) {
            if (state.requests.isEmpty) {
              return const Center(
                child: Text('No requests found'),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<RequestCubit>().getRequests();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.requests.length,
                itemBuilder: (context, index) {
                  final request = state.requests[index];
                  return _RequestCard(
                    request: request,
                    onTap: () {
                      Navigator.push(
                        context,
                        RequestDetailPage.route(request),
                      );
                    },
                  );
                },
              ),
            );
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final RequestModel request;
  final VoidCallback onTap;

  const _RequestCard({
    required this.request,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    request.type.displayName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(request.status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      request.status.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Created: ${request.createdAt?.toLocal().toString().split('.')[0] ?? 'N/A'}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return Colors.orange;
      case RequestStatus.approved:
        return Colors.green;
      case RequestStatus.rejected:
        return Colors.red;
    }
  }
}
