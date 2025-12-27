class LoginRequest {
  final String phoneNumber;
  final String studentCode;
  final String? fcmToken;

  LoginRequest({
    required this.phoneNumber,
    required this.studentCode,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      'phoneNumber': phoneNumber,
      'studentCode': studentCode,
    };

    if (fcmToken != null && fcmToken!.isNotEmpty) {
      json['fcmToken'] = fcmToken;
    }

    return json;
  }
}

