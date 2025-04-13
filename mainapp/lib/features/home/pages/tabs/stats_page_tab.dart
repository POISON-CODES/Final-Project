  part of 'tabs.dart';

  class StatsPageTab extends StatefulWidget {
    const StatsPageTab({super.key});

    @override
    State<StatsPageTab> createState() => _StatsPageTabState();
  }

  class _StatsPageTabState extends State<StatsPageTab> {
    @override
    void initState() {
      super.initState();
      // Load necessary data for statistics
      context.read<CompanyCubit>().getAllCompanies();
      context.read<RequestCubit>().getRequests();
      context.read<ConfigurationCubit>().getAllConfigurations();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Statistics'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<CompanyCubit>().getAllCompanies();
                context.read<RequestCubit>().getRequests();
                context.read<ConfigurationCubit>().getAllConfigurations();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Companies Statistics
              BlocBuilder<CompanyCubit, CompanyState>(
                builder: (context, state) {
                  if (state is CompaniesLoaded) {
                    final companies = state.companies;
                    return _buildStatCard(
                      title: 'Companies Overview',
                      stats: [
                        {
                          'label': 'Total Companies',
                          'value': companies.length.toString(),
                          'icon': Icons.business,
                          'color': Colors.blue,
                        },
                        {
                          'label': 'Active Companies',
                          'value': companies
                              .where((c) =>
                                  c.deadline?.isAfter(DateTime.now()) ?? false)
                              .length
                              .toString(),
                          'icon': Icons.timer,
                          'color': Colors.green,
                        },
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 16),

              // Requests Statistics
              BlocBuilder<RequestCubit, RequestState>(
                builder: (context, state) {
                  if (state is RequestLoaded) {
                    final requests = state.requests;
                    return _buildStatCard(
                      title: 'Requests',
                      stats: [
                        {
                          'label': 'Total Requests',
                          'value': requests.length.toString(),
                          'icon': Icons.description,
                          'color': Colors.purple,
                        },
                        {
                          'label': 'Pending',
                          'value': requests
                              .where((r) => r.status == RequestStatus.pending)
                              .length
                              .toString(),
                          'icon': Icons.pending,
                          'color': Colors.orange,
                        },
                        {
                          'label': 'Approved',
                          'value': requests
                              .where((r) => r.status == RequestStatus.approved)
                              .length
                              .toString(),
                          'icon': Icons.check_circle,
                          'color': Colors.green,
                        },
                        {
                          'label': 'Rejected',
                          'value': requests
                              .where((r) => r.status == RequestStatus.rejected)
                              .length
                              .toString(),
                          'icon': Icons.cancel,
                          'color': Colors.red,
                        },
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildStatCard({
      required String title,
      required List<Map<String, dynamic>> stats,
    }) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (title == 'Companies Overview')
                    IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () => _exportCompaniesToExcel(),
                      tooltip: 'Download Companies Data',
                    ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: stats.length,
                itemBuilder: (context, index) {
                  final stat = stats[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: (stat['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: (stat['color'] as Color).withOpacity(0.3),
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              stat['icon'] as IconData,
                              color: stat['color'] as Color,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              stat['value'] as String,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: stat['color'] as Color,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stat['label'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    Future<void> _exportCompaniesToExcel() async {
      try {
        final state = context.read<CompanyCubit>().state;
        if (state is! CompaniesLoaded) return;

        final companies = state.companies;
        final excel = excel_package.Excel.createExcel();
        final sheet = excel['Companies'];

        // Add headers
        sheet.appendRow([
          excel_package.TextCellValue('Company Name'),
          excel_package.TextCellValue('Positions'),
          excel_package.TextCellValue('CTC'),
          excel_package.TextCellValue('Location'),
          excel_package.TextCellValue('Description'),
          excel_package.TextCellValue('Deadline'),
          excel_package.TextCellValue('Float Time'),
          excel_package.TextCellValue('Eligible Batches'),
        ]);

        // Add data rows
        for (var company in companies) {
          sheet.appendRow([
            excel_package.TextCellValue(company.name),
            excel_package.TextCellValue(company.positions.join(', ')),
            excel_package.TextCellValue(company.ctc.join(', ')),
            excel_package.TextCellValue(company.location ?? 'N/A'),
            excel_package.TextCellValue(company.description ?? 'N/A'),
            excel_package.TextCellValue(
                company.deadline?.toIso8601String() ?? 'N/A'),
            excel_package.TextCellValue(company.floatTime.toIso8601String()),
            excel_package.TextCellValue(company.eligibleBatchesIds.join(', ')),
          ]);
        }

        // Save the file
        final fileBytes = excel.encode();
        if (fileBytes == null) {
          throw Exception('Failed to generate Excel file');
        }

        // Get the downloads directory
        final directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = 'companies_data_$timestamp.xlsx';
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(fileBytes);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('File saved as: $fileName'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              action: SnackBarAction(
                label: 'Open',
                onPressed: () async {
                  if (await file.exists()) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('File saved in Downloads folder'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error exporting data: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
