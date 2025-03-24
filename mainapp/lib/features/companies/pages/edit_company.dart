part of 'company_pages.dart';

class EditCompanyPage extends StatefulWidget {
  final CompanyModel company;

  static MaterialPageRoute route(CompanyModel company) => MaterialPageRoute(
      builder: (context) => EditCompanyPage(company: company));

  const EditCompanyPage({super.key, required this.company});

  @override
  State<EditCompanyPage> createState() => _EditCompanyPageState();
}

class _EditCompanyPageState extends State<EditCompanyPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _providerController;

  final List<TextEditingController> _positionControllers = [];
  final List<TextEditingController> _ctcControllers = [];

  final List<String> _selectedBatchesIds = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with company data
    _nameController = TextEditingController(text: widget.company.name);
    _locationController =
        TextEditingController(text: widget.company.location ?? '');
    _providerController = TextEditingController(text: widget.company.provider);
    _selectedBatchesIds.addAll(widget.company.eligibleBatchesIds);

    // Initialize position and CTC controllers
    for (int i = 0; i < widget.company.positions.length; i++) {
      _positionControllers
          .add(TextEditingController(text: widget.company.positions[i]));
      _ctcControllers.add(TextEditingController(text: widget.company.ctc[i]));
    }

    // Load configurations and forms for selection
    context.read<ConfigurationCubit>().getAllConfigurations();
    context.read<form_cubit.FormCubit>().getAllForms();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _providerController.dispose();

    for (var controller in _positionControllers) {
      controller.dispose();
    }

    for (var controller in _ctcControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  // UI will be similar to create page but with pre-filled data
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Company", actions: [
        IconButton(
          onPressed: () {
            // Update company logic would go here
          },
          icon: const Icon(Icons.check),
        ),
      ]),
      body: Center(
        child: Text("Edit company page - will be implemented"),
      ),
    );
  }
}
