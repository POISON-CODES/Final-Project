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
  List<String> _selectedFileNames = [];

  Future<void> _pickFiles() async {
    // Request permissions
    PermissionStatus mediaAccessStatus =
        await Permission.accessMediaLocation.request();
        await Permission.photos.request();
        await Permission.videos.request();
        await Permission.audio.request();
    PermissionStatus manageExternalStorageStatus =
        await Permission.manageExternalStorage.request();
    PermissionStatus storageAccessStatus = await Permission.storage.request();

    if (manageExternalStorageStatus.isGranted &&
        mediaAccessStatus.isGranted &&
        storageAccessStatus.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: widget.count > 1,
      );

      if (result != null) {
        setState(() {
          _selectedFileNames =
              result.files.map((file) => file.name).take(widget.count).toList();
        });
      }
    } else {
      // Handle the case when permission is not granted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Storage and media location permissions are required to pick files.'),
          backgroundColor: Colors.redAccent,
        ),
      );
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
        if (_selectedFileNames.isNotEmpty) ...[
          SizedBox(height: 5),
          ..._selectedFileNames.map((fileName) => Text(
                fileName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              )),
        ],
      ],
    );
  }
}
