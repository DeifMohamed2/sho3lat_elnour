class ClassModel {
  final String id;
  final String className;
  final String academicLevel;
  final String section;

  ClassModel({
    required this.id,
    required this.className,
    required this.academicLevel,
    required this.section,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      className: json['className']?.toString() ?? '',
      academicLevel: json['academicLevel']?.toString() ?? '',
      section: json['section']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'className': className,
      'academicLevel': academicLevel,
      'section': section,
    };
  }
}


