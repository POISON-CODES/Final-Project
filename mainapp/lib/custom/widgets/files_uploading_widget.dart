part of 'custom_global_widgets.dart';

void showUploadingDialog({
  required BuildContext context,
  String title = "Uploading Files...",
  String message = "Please wait while your files are being uploaded.",
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(title),
            SizedBox(height: 8),
            Text(message),
          ],
        ),
      );
    },
  );
}
