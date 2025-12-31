class Certificate {
  final String id;
  final String title;
  final String? description;
  final String certificateType;
  final String? certificateTypeName;
  final String? certificateTypeNameEn;
  final String? fileUrl;
  final String? fileType;
  final String? fileName;
  final int? fileSize;
  final bool isLocked;
  final DateTime? lockedAt;
  final DateTime? unlockedAt;
  final String? unlockedBy;
  final String? uploadedBy;
  final String? academicYear;
  final String? semester;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Certificate({
    required this.id,
    required this.title,
    this.description,
    required this.certificateType,
    this.certificateTypeName,
    this.certificateTypeNameEn,
    this.fileUrl,
    this.fileType,
    this.fileName,
    this.fileSize,
    this.isLocked = false,
    this.lockedAt,
    this.unlockedAt,
    this.unlockedBy,
    this.uploadedBy,
    this.academicYear,
    this.semester,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString(),
      certificateType: json['certificateType']?.toString() ?? '',
      certificateTypeName: json['certificateTypeName']?.toString(),
      certificateTypeNameEn: json['certificateTypeNameEn']?.toString(),
      fileUrl: json['fileUrl']?.toString(),
      fileType: json['fileType']?.toString(),
      fileName: json['fileName']?.toString(),
      fileSize: json['fileSize'],
      isLocked: json['isLocked'] ?? false,
      lockedAt: json['lockedAt'] != null
          ? DateTime.tryParse(json['lockedAt'].toString())
          : null,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.tryParse(json['unlockedAt'].toString())
          : null,
      unlockedBy: json['unlockedBy']?.toString(),
      uploadedBy: json['uploadedBy']?.toString(),
      academicYear: json['academicYear']?.toString(),
      semester: json['semester']?.toString(),
      notes: json['notes']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'certificateType': certificateType,
      'certificateTypeName': certificateTypeName,
      'certificateTypeNameEn': certificateTypeNameEn,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'fileName': fileName,
      'fileSize': fileSize,
      'isLocked': isLocked,
      'lockedAt': lockedAt?.toIso8601String(),
      'unlockedAt': unlockedAt?.toIso8601String(),
      'unlockedBy': unlockedBy,
      'uploadedBy': uploadedBy,
      'academicYear': academicYear,
      'semester': semester,
      'notes': notes,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Get semester name in Arabic
  String get semesterArabic {
    switch (semester?.toLowerCase()) {
      case 'first':
        return 'الفصل الأول';
      case 'second':
        return 'الفصل الثاني';
      default:
        return semester ?? '';
    }
  }

  /// Get formatted file size
  String get formattedFileSize {
    if (fileSize == null) return '';
    if (fileSize! < 1024) return '$fileSize B';
    if (fileSize! < 1024 * 1024) return '${(fileSize! / 1024).toStringAsFixed(1)} KB';
    return '${(fileSize! / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// Check if certificate is a PDF
  bool get isPdf => fileType?.toLowerCase() == 'pdf';
}

class CertificatesInfo {
  final List<Certificate> list;
  final int total;
  final int unlocked;
  final int locked;

  CertificatesInfo({
    required this.list,
    required this.total,
    this.unlocked = 0,
    this.locked = 0,
  });

  factory CertificatesInfo.fromJson(Map<String, dynamic> json) {
    return CertificatesInfo(
      list: (json['list'] as List<dynamic>?)
              ?.map((item) => Certificate.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      total: json['total'] ?? 0,
      unlocked: json['unlocked'] ?? 0,
      locked: json['locked'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'list': list.map((c) => c.toJson()).toList(),
      'total': total,
      'unlocked': unlocked,
      'locked': locked,
    };
  }
}
