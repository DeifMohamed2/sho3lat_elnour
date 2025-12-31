class PaymentRecord {
  final String id;
  final double amount;
  final DateTime paymentDate;
  final String paymentMethod;
  final String? notes;
  final String? receiptNumber;

  PaymentRecord({
    required this.id,
    required this.amount,
    required this.paymentDate,
    required this.paymentMethod,
    this.notes,
    this.receiptNumber,
  });

  factory PaymentRecord.fromJson(Map<String, dynamic> json) {
    return PaymentRecord(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'].toString())
          : DateTime.now(),
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      notes: json['notes']?.toString(),
      receiptNumber: json['receiptNumber']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'amount': amount,
      'paymentDate': paymentDate.toIso8601String(),
      'paymentMethod': paymentMethod,
      'notes': notes,
      'receiptNumber': receiptNumber,
    };
  }

  /// Get payment method in Arabic
  String get paymentMethodArabic {
    switch (paymentMethod.toLowerCase()) {
      case 'cash':
        return 'نقداً';
      case 'card':
        return 'بطاقة';
      case 'transfer':
        return 'تحويل بنكي';
      case 'check':
        return 'شيك';
      default:
        return paymentMethod;
    }
  }

  /// Get formatted payment date
  String get formattedPaymentDate {
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
    return '${paymentDate.day} ${monthNames[paymentDate.month]} ${paymentDate.year}';
  }
}

class PaymentsInfo {
  final List<PaymentRecord> recent;
  final List<PaymentRecord> all;
  final int totalCount;

  PaymentsInfo({
    required this.recent,
    required this.all,
    required this.totalCount,
  });

  factory PaymentsInfo.fromJson(Map<String, dynamic> json) {
    return PaymentsInfo(
      recent: (json['recent'] as List<dynamic>?)
              ?.map((item) => PaymentRecord.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      all: (json['all'] as List<dynamic>?)
              ?.map((item) => PaymentRecord.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalCount: json['totalCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recent': recent.map((r) => r.toJson()).toList(),
      'all': all.map((r) => r.toJson()).toList(),
      'totalCount': totalCount,
    };
  }
}
