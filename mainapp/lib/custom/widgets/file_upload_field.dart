part of 'custom_global_widgets.dart';

class FileUploadField extends FormFields {
  final String label;
  final int count;
  const FileUploadField({
    super.key,
    required this.label,
    required this.count,
  });

  @override
  State<FileUploadField> createState() => _FileUploadFieldState();
}

class _FileUploadFieldState extends State<FileUploadField> {
  List<CustomFile>? listFiles;
  Future<void> _pickFiles() async {
    try {
      var _selectedFiles = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      listFiles = _selectedFiles!.files
          .map((e) => CustomFile.fromPlatformFile(e))
          .toList();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = "Select ${widget.count} files";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.label} : Select ${widget.count} files",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickFiles,
                    child: Icon(
                      Icons.upload,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              Text(
                listFiles!
                    .map((e) => e.name.length > 30
                        ? '${e.name.trim().substring(0, 30)}...'
                        : e.name)
                    .join("\n "),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
