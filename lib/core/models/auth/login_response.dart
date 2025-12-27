import '../student/student_model.dart';

class LoginResponse {
  final bool success;
  final String message;
  final String messageEn;
  final String token;
  final StudentModel? student;
  final List<StudentModel> students;
  final bool hasBlockedStudents;
  final int blockedCount;
  final String? blockReason;

  LoginResponse({
    required this.success,
    required this.message,
    required this.messageEn,
    required this.token,
    this.student,
    required this.students,
    required this.hasBlockedStudents,
    required this.blockedCount,
    this.blockReason,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message']?.toString() ?? '',
      messageEn: json['message_en']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      student:
          json['student'] != null
              ? StudentModel.fromJson(json['student'] as Map<String, dynamic>)
              : null,
      students:
          (json['students'] as List<dynamic>?)
              ?.map(
                (item) => StudentModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      hasBlockedStudents: json['hasBlockedStudents'] ?? false,
      blockedCount: json['blockedCount'] ?? 0,
      blockReason: json['blockReason']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'message_en': messageEn,
      'token': token,
      'student': student?.toJson(),
      'students': students.map((s) => s.toJson()).toList(),
      'hasBlockedStudents': hasBlockedStudents,
      'blockedCount': blockedCount,
      if (blockReason != null) 'blockReason': blockReason,
    };
  }
}

