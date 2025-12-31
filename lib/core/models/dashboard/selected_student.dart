import 'student_class.dart';

class SelectedStudent {
  final String id;
  final String name;
  final String code;
  final StudentClass? classInfo;
  final String? parentName;
  final String? parentPhone1;
  final String? address;
  final DateTime? dateOfBirth;
  final bool isBlocked;
  final String? blockReason;

  SelectedStudent({
    required this.id,
    required this.name,
    required this.code,
    this.classInfo,
    this.parentName,
    this.parentPhone1,
    this.address,
    this.dateOfBirth,
    required this.isBlocked,
    this.blockReason,
  });

  factory SelectedStudent.fromJson(Map<String, dynamic> json) {
    return SelectedStudent(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      classInfo: json['class'] != null
          ? StudentClass.fromJson(json['class'] as Map<String, dynamic>)
          : null,
      parentName: json['parentName']?.toString(),
      parentPhone1: json['parentPhone1']?.toString(),
      address: json['address']?.toString(),
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'].toString())
          : null,
      isBlocked: json['isBlocked'] ?? false,
      blockReason: json['blockReason']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'class': classInfo?.toJson(),
      'parentName': parentName,
      'parentPhone1': parentPhone1,
      'address': address,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'isBlocked': isBlocked,
      'blockReason': blockReason,
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
      'scheduleImage': classInfo?.scheduleImage,
      'parentName': parentName,
      'parentPhone1': parentPhone1,
      'address': address,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'isBlocked': isBlocked,
      'blockReason': blockReason,
      'avatar': '👦', // Default avatar
    };
  }
}
