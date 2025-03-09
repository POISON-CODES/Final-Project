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
  Future<void> _pickFiles() async {
    try {
      var _selectedFiles = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      List<PlatformFile> listfiles = _selectedFiles!.files.toList();
      listfiles.forEach((platformfile) {
        platformfile.extension;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickFiles,
                icon: Icon(Icons.upload),
                label: Text("Upload Files"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
