class Helpers {
  // Add your helper functions here
  static String formatPhoneNumber(String phone) {
    // Remove all non-digit characters
    return phone.replaceAll(RegExp(r'[^\d]'), '');
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    // Basic phone validation - adjust regex based on your requirements
    return RegExp(r'^[0-9]{10,15}$').hasMatch(phone);
  }
}


