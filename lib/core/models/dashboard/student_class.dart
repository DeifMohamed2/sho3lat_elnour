class StudentClass {
  final String id;
  final String className;
  final String academicLevel;
  final String section;
  final String? scheduleImage;

  StudentClass({
    required this.id,
    required this.className,
    required this.academicLevel,
    required this.section,
    this.scheduleImage,
  });

  factory StudentClass.fromJson(Map<String, dynamic> json) {
    return StudentClass(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      className: json['className']?.toString() ?? '',
      academicLevel: json['academicLevel']?.toString() ?? '',
      section: json['section']?.toString() ?? '',
      scheduleImage: json['scheduleImage']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'className': className,
      'academicLevel': academicLevel,
      'section': section,
      if (scheduleImage != null) 'scheduleImage': scheduleImage,
    };
  }
}
