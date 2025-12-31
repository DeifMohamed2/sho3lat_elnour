class AttendanceRecord {
  final String id;
  final DateTime date;
  final String status;
  final DateTime? entryTime;
  final DateTime? exitTime;
  final String? notes;

  AttendanceRecord({
    required this.id,
    required this.date,
    required this.status,
    this.entryTime,
    this.exitTime,
    this.notes,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      date: json['date'] != null
          ? DateTime.parse(json['date'].toString())
          : DateTime.now(),
      status: json['status']?.toString() ?? '',
      entryTime: json['entryTime'] != null
          ? DateTime.tryParse(json['entryTime'].toString())
          : null,
      exitTime: json['exitTime'] != null
          ? DateTime.tryParse(json['exitTime'].toString())
          : null,
      notes: json['notes']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'date': date.toIso8601String(),
      'status': status,
      'entryTime': entryTime?.toIso8601String(),
      'exitTime': exitTime?.toIso8601String(),
      'notes': notes,
    };
  }

  /// Get status in Arabic
  String get statusArabic {
    switch (status.toLowerCase()) {
      case 'present':
        return 'حاضر';
      case 'absent':
        return 'غائب';
      case 'late':
        return 'متأخر';
      case 'early_leave':
      case 'earlyleave':
        return 'انصراف مبكر';
      case 'permission':
        return 'إذن';
      default:
        return status;
    }
  }

  /// Get status key for filtering (lowercase)
  String get statusKey {
    switch (status.toLowerCase()) {
      case 'present':
        return 'present';
      case 'absent':
        return 'absent';
      case 'late':
        return 'late';
      case 'early_leave':
      case 'earlyleave':
        return 'earlyLeave';
      case 'permission':
        return 'permission';
      default:
        return status.toLowerCase();
    }
  }

  /// Get formatted entry time
  String get formattedEntryTime {
    if (entryTime == null) return '';
    final hour = entryTime!.hour;
    final minute = entryTime!.minute.toString().padLeft(2, '0');
    final period = hour < 12 ? 'صباحاً' : 'مساءً';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  /// Get formatted date in Arabic
  String get formattedDateArabic {
    final monthNames = [
      '',
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return '${date.day} ${monthNames[date.month]} ${date.year}';
  }

  /// Get day name in Arabic
  String get dayNameArabic {
    final dayNames = [
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return dayNames[date.weekday - 1];
  }
}
