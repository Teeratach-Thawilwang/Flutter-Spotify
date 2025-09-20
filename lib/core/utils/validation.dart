String? fullnameValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fullname is required.';
  }
  if (value.length < 6) return 'Fullname must be at least 6 characters long';
  if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
    return 'Full name must contain only letters and spaces';
  }
  if (value.trim().isEmpty) {
    return 'Full name cannot be just spaces';
  }
  return null;
}

String? emailValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required.';
  }
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Email format is invalid';
  }
  return null;
}

String? passwordValidation(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 8) return 'Password must be at least 8 characters long';
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Must contain at least 1 uppercase letter';
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return 'Must contain at least 1 number';
  }
  if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
    return 'Must contain at least 1 special character (!@#\$&*~)';
  }
  return null;
}
