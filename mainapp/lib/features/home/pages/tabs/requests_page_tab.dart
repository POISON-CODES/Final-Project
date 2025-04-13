part of 'tabs.dart';

class RequestsPageTab extends StatefulWidget {
  const RequestsPageTab({super.key});

  @override
  State<RequestsPageTab> createState() => _RequestsPageTabState();
}

class _RequestsPageTabState extends State<RequestsPageTab> {
  RequestStatus? _selectedFilter;
  RequestType? _selectedTypeFilter;

  @override
  void initState() {
    super.initState();
    // Load requests when the tab is initialized
    context.read<RequestCubit>().getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestCubit, RequestState>(
      builder: (context, state) {
        if (state is RequestLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RequestError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<RequestCubit>().getRequests(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is RequestLoaded) {
          final requests = state.requests.where((request) {
            if (_selectedFilter != null && request.status != _selectedFilter) {
              return false;
            }
            if (_selectedTypeFilter != null &&
                request.type != _selectedTypeFilter) {
              return false;
            }
            return true;
          }).toList();

          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  const Text('Requests'),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getFilterStatusColor(_selectedFilter),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _selectedFilter?.name.toUpperCase() ?? 'ALL',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => context.read<RequestCubit>().getRequests(),
                ),
              ],
            ),
            body: Column(
              children: [
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: _selectedFilter == null,
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = null;
                          });
                        },
                        labelStyle: const TextStyle(fontSize: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                      ),
                      const SizedBox(width: 8),
                      ...RequestStatus.values.map((status) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(status.name.toLowerCase()),
                            selected: _selectedFilter == status,
                            onSelected: (selected) {
                              setState(() {
                                _selectedFilter = selected ? status : null;
                              });
                            },
                            backgroundColor:
                                _getFilterStatusColor(status).withOpacity(0.1),
                            selectedColor: _getFilterStatusColor(status),
                            labelStyle: TextStyle(
                              color: _selectedFilter == status
                                  ? Colors.white
                                  : _getFilterStatusColor(status),
                              fontSize: 12,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                Expanded(
                  child: requests.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.inbox,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _selectedFilter != null
                                    ? 'No requests found with status ${_selectedFilter!.name}'
                                    : 'No requests found',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            return _RequestCard(
                              request: request,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RequestDetailPage(
                                      request: request,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Color _getFilterStatusColor(RequestStatus? status) {
    switch (status) {
      case RequestStatus.pending:
        return Colors.orange;
      case RequestStatus.approved:
        return Colors.green;
      case RequestStatus.rejected:
        return Colors.red;
      default:
        return Colors.grey;
    }
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
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.type.displayName,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            String userName = 'Unknown User';
                            if (state is AuthAdminAuthenticated ||
                                state is AuthStudentAuthenticated ||
                                state is AuthCoordinatorAuthenticated) {
                              userName = (state as dynamic).user.name;
                            }
                            return Text(
                              'By: $userName',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(request.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _getStatusColor(request.status),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      request.status.displayName,
                      style: TextStyle(
                        color: _getStatusColor(request.status),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Created: ${_formatDate(request.createdAt)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
              if (request.updatedAt != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.update,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Updated: ${_formatDate(request.updatedAt)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ],
              if (request.approvedBy != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Colors.green[600],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Approved by: ${request.approvedBy}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green[600],
                          ),
                    ),
                  ],
                ),
              ],
              if (request.rejectedBy != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      size: 16,
                      color: Colors.red[600],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Rejected by: ${request.rejectedBy}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.red[600],
                          ),
                    ),
                  ],
                ),
                if (request.rejectionReason != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.red[600],
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Reason: ${request.rejectionReason}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.red[600],
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
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
