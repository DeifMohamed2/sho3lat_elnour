class FinancialInfo {
  final double totalSchoolFees;
  final double totalPaid;
  final double remainingBalance;
  final double paymentProgress;
  final DateTime? lastPaymentDate;

  FinancialInfo({
    required this.totalSchoolFees,
    required this.totalPaid,
    required this.remainingBalance,
    required this.paymentProgress,
    this.lastPaymentDate,
  });

  factory FinancialInfo.fromJson(Map<String, dynamic> json) {
    return FinancialInfo(
      totalSchoolFees: (json['totalSchoolFees'] ?? 0).toDouble(),
      totalPaid: (json['totalPaid'] ?? 0).toDouble(),
      remainingBalance: (json['remainingBalance'] ?? 0).toDouble(),
      paymentProgress: (json['paymentProgress'] ?? 0).toDouble(),
      lastPaymentDate: json['lastPaymentDate'] != null
          ? DateTime.tryParse(json['lastPaymentDate'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalSchoolFees': totalSchoolFees,
      'totalPaid': totalPaid,
      'remainingBalance': remainingBalance,
      'paymentProgress': paymentProgress,
      'lastPaymentDate': lastPaymentDate?.toIso8601String(),
    };
  }

  /// Get formatted last payment date
  String get formattedLastPaymentDate {
    if (lastPaymentDate == null) return '';
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
    return '${lastPaymentDate!.day} ${monthNames[lastPaymentDate!.month]} ${lastPaymentDate!.year}';
  }

  /// Check if fully paid
  bool get isFullyPaid => remainingBalance <= 0;

  /// Get progress as percentage (0.0 to 1.0)
  double get progressFraction => paymentProgress / 100;
}
