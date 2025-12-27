class ApiError {
  final bool success;
  final String message;
  final String messageEn;
  final String? error;
  final String? blockReason;
  final int? statusCode;

  ApiError({
    required this.success,
    required this.message,
    required this.messageEn,
    this.error,
    this.blockReason,
    this.statusCode,
  });

  factory ApiError.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    return ApiError(
      success: json['success'] ?? false,
      message: json['message']?.toString() ?? 'حدث خطأ غير معروف',
      messageEn: json['message_en']?.toString() ?? 'Unknown error occurred',
      error: json['error']?.toString(),
      blockReason: json['blockReason']?.toString(),
      statusCode: statusCode,
    );
  }

  factory ApiError.fromString(String message, {int? statusCode}) {
    return ApiError(
      success: false,
      message: message,
      messageEn: message,
      statusCode: statusCode,
    );
  }

  @override
  String toString() {
    return message;
  }
}

