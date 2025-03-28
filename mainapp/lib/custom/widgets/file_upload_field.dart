part of 'custom_global_widgets.dart';

class FileUploadField extends FormFields {
  final List<String>? allowedExtensions;
  @override
  final int fileCount;
  final void Function(List<PlatformFile>)? onFilesSelected;

  const FileUploadField({
    super.key,
    required super.label,
    super.fieldType = FieldType.file,
    super.dropDownItemsList,
    this.allowedExtensions,
    this.fileCount = 1,
    this.onFilesSelected,
    super.isRequired = true,
  });

  @override
  State<FileUploadField> createState() => _FileUploadFieldState();
}

class _FileUploadFieldState extends State<FileUploadField> {
  final List<PlatformFile> _selectedFiles = [];

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: widget.allowedExtensions != null ? FileType.custom : FileType.any,
        allowMultiple: widget.fileCount > 1,
        allowedExtensions: widget.allowedExtensions,
      );

      if (result != null) {
        setState(() {
          // If fileCount is limited, ensure we don't exceed it
          if (widget.fileCount > 0) {
            // Clear previous selection if we're at the limit
            if (_selectedFiles.length + result.files.length >
                widget.fileCount) {
              _selectedFiles.clear();
            }

            // Add only up to the file count limit
            if (result.files.length > widget.fileCount) {
              _selectedFiles.addAll(result.files.sublist(0, widget.fileCount));
            } else {
              _selectedFiles.addAll(result.files);
            }

            // If we're still over limit (due to previous selections), trim
            if (_selectedFiles.length > widget.fileCount) {
              _selectedFiles.removeRange(
                  widget.fileCount, _selectedFiles.length);
            }
          } else {
            // No limit, add all files
            _selectedFiles.addAll(result.files);
          }
        });

        // Notify parent of the selected files
        if (widget.onFilesSelected != null) {
          widget.onFilesSelected!(_selectedFiles);
        }
      }
    } catch (e) {
      // Handle error
      print("Error picking files: $e");
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });

    // Notify parent of the updated selection
    if (widget.onFilesSelected != null) {
      widget.onFilesSelected!(_selectedFiles);
    }
  }

  String _getFileCountText() {
    if (widget.fileCount == 1) {
      return "1 file";
    } else if (widget.fileCount > 1) {
      return "${widget.fileCount} files";
    } else {
      return "Multiple files";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.label}${widget.isRequired ? ' *' : ''}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Display selected files
        if (_selectedFiles.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selected Files:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...List.generate(
                _selectedFiles.length,
                (index) => ListTile(
                  leading: Icon(
                    _getFileIcon(_selectedFiles[index]),
                    color: Colors.blue,
                  ),
                  title: Text(_selectedFiles[index].name),
                  subtitle: Text(
                    '${(_selectedFiles[index].size / 1024).toStringAsFixed(2)} KB',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeFile(index),
                  ),
                  dense: true,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),

        // Upload button with file count
        ElevatedButton.icon(
          onPressed:
              _selectedFiles.length >= widget.fileCount && widget.fileCount > 0
                  ? null // Disable if max files reached
                  : _pickFiles,
          icon: const Icon(Icons.upload_file),
          label: Text(
            _selectedFiles.isEmpty
                ? "Select ${_getFileCountText()}"
                : widget.fileCount > 0
                    ? "Selected ${_selectedFiles.length}/${widget.fileCount}"
                    : "Selected ${_selectedFiles.length} files",
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey,
          ),
        ),

        if (widget.allowedExtensions != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Supported formats: ${widget.allowedExtensions!.map((e) => e.toUpperCase()).join(", ")}",
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  IconData _getFileIcon(PlatformFile file) {
    final extension = file.extension?.toLowerCase() ?? '';

    if (extension == 'pdf') {
      return Icons.picture_as_pdf;
    } else if (['doc', 'docx'].contains(extension)) {
      return Icons.description;
    } else if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(extension)) {
      return Icons.image;
    } else if (['mp4', 'mov', 'avi', 'wmv'].contains(extension)) {
      return Icons.video_file;
    } else if (['mp3', 'wav', 'ogg'].contains(extension)) {
      return Icons.audio_file;
    } else if (['zip', 'rar', '7z', 'tar', 'gz'].contains(extension)) {
      return Icons.folder_zip;
    } else {
      return Icons.insert_drive_file;
    }
  }
}
