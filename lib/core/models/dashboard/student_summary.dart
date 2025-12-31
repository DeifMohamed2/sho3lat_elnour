import 'student_class.dart';

class StudentSummary {
  final String id;
  final String name;
  final String code;
  final StudentClass? classInfo;
  final double totalSchoolFees;
  final double totalPaid;
  final double remainingBalance;
  final bool isBlocked;
  final bool isSelected;

  StudentSummary({
    required this.id,
    required this.name,
    required this.code,
    this.classInfo,
    required this.totalSchoolFees,
    required this.totalPaid,
    required this.remainingBalance,
    required this.isBlocked,
    required this.isSelected,
  });

  factory StudentSummary.fromJson(Map<String, dynamic> json) {
    return StudentSummary(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      classInfo: json['class'] != null
          ? StudentClass.fromJson(json['class'] as Map<String, dynamic>)
          : null,
      totalSchoolFees: (json['totalSchoolFees'] ?? 0).toDouble(),
      totalPaid: (json['totalPaid'] ?? 0).toDouble(),
      remainingBalance: (json['remainingBalance'] ?? 0).toDouble(),
      isBlocked: json['isBlocked'] ?? false,
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'class': classInfo?.toJson(),
      'totalSchoolFees': totalSchoolFees,
      'totalPaid': totalPaid,
      'remainingBalance': remainingBalance,
      'isBlocked': isBlocked,
      'isSelected': isSelected,
    };
  }

  /// Convert to a simple map format for compatibility with existing widgets
  Map<String, dynamic> toWidgetMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'class': classInfo?.className ?? '',
      'grade': classInfo?.academicLevel ?? '',
      'section': classInfo?.section ?? '',
      'totalSchoolFees': totalSchoolFees,
      'totalPaid': totalPaid,
      'remainingBalance': remainingBalance,
      'isBlocked': isBlocked,
      'isSelected': isSelected,
      'avatar': '👦', // Default avatar
    };
  }
}
