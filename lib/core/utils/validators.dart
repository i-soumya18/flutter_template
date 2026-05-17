class Validators {
  const Validators._();

  static String? requiredField(String? value, {String field = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (requiredField(value, field: 'Email') case final message?) {
      return message;
    }
    final isValid =
        RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!.trim());
    return isValid ? null : 'Enter a valid email';
  }

  static String? password(String? value) {
    if (requiredField(value, field: 'Password') case final message?) {
      return message;
    }
    if (value!.length < 8) return 'Password must be at least 8 characters';
    return null;
  }
}
