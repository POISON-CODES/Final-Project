part of 'utils.dart';

String? passwordValidator(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Password is required';
  }
  if (val.length < 8 || val.length > 25) {
    return 'Password must be between 8-25 characters';
  }

  // List of commonly used passwords (You can expand this list)
  List<String> commonPasswords = [
    'password',
    '12345678',
    'qwerty123',
    'iloveyou',
    'admin123',
    'welcome123',
    'letmein',
    'passw0rd',
    '123456789',
    'abc123',
    'football',
    'monkey',
    'dragon',
    'sunshine',
    'princess'
  ];

  if (commonPasswords.contains(val)) {
    return 'Choose a stronger password';
  }

  return null; // Valid password
}

String? phoneValidator(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Phone number is required';
  }
  final phoneRegex = RegExp(r"^\+91[6-9]\d{9}$");
  if (!phoneRegex.hasMatch(val.trim())) {
    return 'Enter a valid phone number (e.g., +919876543210)';
  }
  return null; // Valid phone number
}

String? emailValidator(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Email is required';
  }
  final emailRegex =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  if (!emailRegex.hasMatch(val.trim())) {
    return 'Enter a valid email address';
  }
  return null; // Valid email
}

String? nameValidator(String? val) {
  if (val == null || val.trim().isEmpty) {
    return 'Name is required';
  }
  if (val.trim().length < 2) {
    return 'Name must be at least 2 characters long';
  }
  if (val.trim().length > 50) {
    return 'Name must be less than 50 characters long';
  }
  if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(val.trim())) {
    return 'Name can only contain letters and spaces';
  }
  return null; // Valid name
}
