import 'class_model.dart';

class StudentModel {
  final String id;
  final String name;
  final String code;
  final ClassModel? classInfo;
  final double totalSchoolFees;
  final double totalPaid;
  final double remainingBalance;

  StudentModel({
    required this.id,
    required this.name,
    required this.code,
    this.classInfo,
    required this.totalSchoolFees,
    required this.totalPaid,
    required this.remainingBalance,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      classInfo: json['class'] != null
          ? ClassModel.fromJson(json['class'] as Map<String, dynamic>)
          : null,
      totalSchoolFees: (json['totalSchoolFees'] ?? 0).toDouble(),
      totalPaid: (json['totalPaid'] ?? 0).toDouble(),
      remainingBalance: (json['remainingBalance'] ?? 0).toDouble(),
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
    };
  }
}


