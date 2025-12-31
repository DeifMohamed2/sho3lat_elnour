class TodayAttendance {
  final String status;
  final DateTime? entryTime;
  final DateTime? exitTime;
  final String? notes;

  TodayAttendance({
    required this.status,
    this.entryTime,
    this.exitTime,
    this.notes,
  });

  factory TodayAttendance.fromJson(Map<String, dynamic> json) {
    return TodayAttendance(
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

  /// Get formatted entry time
  String get formattedEntryTime {
    if (entryTime == null) return '';
    final hour = entryTime!.hour;
    final minute = entryTime!.minute.toString().padLeft(2, '0');
    final period = hour < 12 ? 'صباحاً' : 'مساءً';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  /// Get formatted exit time
  String get formattedExitTime {
    if (exitTime == null) return '';
    final hour = exitTime!.hour;
    final minute = exitTime!.minute.toString().padLeft(2, '0');
    final period = hour < 12 ? 'صباحاً' : 'مساءً';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  /// Check if student is present
  bool get isPresent => status.toLowerCase() == 'present';

  /// Check if student is absent
  bool get isAbsent => status.toLowerCase() == 'absent';

  /// Check if student is late
  bool get isLate => status.toLowerCase() == 'late';
}
