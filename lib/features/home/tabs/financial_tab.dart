import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/dashboard/dashboard_response.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/tab_header.dart';

class FinancialTab extends StatefulWidget {
  final Map<String, dynamic>? student;
  final DashboardResponse? dashboardResponse;
  final VoidCallback? onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;
  final Future<void> Function()? onRefresh;

  const FinancialTab({
    super.key,
    this.student,
    this.dashboardResponse,
    this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
    this.onRefresh,
  });

  @override
  State<FinancialTab> createState() => _FinancialTabState();
}

class _FinancialTabState extends State<FinancialTab> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final financial = widget.dashboardResponse?.financial;
    final payments = widget.dashboardResponse?.payments;

    return Column(
      children: [
        TabHeader(
          title: widget.title,
          student: widget.student,
          onShowStudentSelector: widget.onShowStudentSelector ?? () {},
          onProfileTap: widget.onProfileTap,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              if (widget.onRefresh != null) {
                widget.onRefresh!();
              }
            },
            color: AppTheme.primaryBlue,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Cards
                  _buildSummaryCards(financial, payments, l10n),
                  const SizedBox(height: 24),
                  // Payments Table
                  _buildPaymentsSection(payments, l10n),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards(
    dynamic financial,
    dynamic payments,
    AppLocalizations l10n,
  ) {
    final totalFees = financial?.totalSchoolFees ?? 0.0;
    final totalPaid = financial?.totalPaid ?? 0.0;
    final remaining = financial?.remainingBalance ?? 0.0;
    final paymentCount = payments?.totalCount ?? 0;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.account_balance,
                iconColor: AppTheme.primaryBlue,
                iconBgColor: AppTheme.primaryBlue.withValues(alpha: 0.15),
                label: l10n.totalFees,
                value: '${totalFees.toStringAsFixed(2)} ${l10n.currency}',
                valueColor: Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                iconBgColor: Colors.green.shade100,
                label: l10n.paidAmount,
                value: '${totalPaid.toStringAsFixed(2)} ${l10n.currency}',
                valueColor: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.pending,
                iconColor: Colors.red,
                iconBgColor: Colors.red.shade100,
                label: l10n.remainingBalance,
                value: '${remaining.toStringAsFixed(2)} ${l10n.currency}',
                valueColor: Colors.red,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.receipt_long,
                iconColor: Colors.orange,
                iconBgColor: Colors.orange.shade100,
                label: l10n.paymentCount,
                value: '$paymentCount',
                valueColor: AppTheme.gray800,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: AppTheme.tajawal(
                    fontSize: 12,
                    color: AppTheme.gray600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.tajawal(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsSection(dynamic payments, AppLocalizations l10n) {
    final allPayments = payments?.all ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.receipt_long,
                color: AppTheme.primaryBlue,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.paymentHistory,
              style: AppTheme.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.gray800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Payment Cards
        if (allPayments.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 48,
                  color: AppTheme.gray400,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.noPayments,
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    color: AppTheme.gray500,
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: allPayments.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final payment = allPayments[index];
              return _buildPaymentCard(index + 1, payment, l10n);
            },
          ),
      ],
    );
  }

  Widget _buildPaymentCard(int index, dynamic payment, AppLocalizations l10n) {
    // Debug prints
    print('========== PAYMENT CARD DEBUG ==========');
    print('Payment Index: $index');
    print('Payment Object: $payment');
    print('Payment Type: ${payment.runtimeType}');
    print('Payment Amount: ${payment.amount}');
    print('Payment Date: ${payment.paymentDate}');
    print('Payment Method: ${payment.paymentMethod}');
    print('Payment Method Arabic: ${payment.paymentMethodArabic}');
    print('Formatted Date: ${payment.formattedPaymentDate}');
    print('========================================');
    
    final methodColor = _getPaymentMethodColor(payment.paymentMethod);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.gray200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card Header with Amount
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$index',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.paymentNumber(index),
                              style: AppTheme.tajawal(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.gray800,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              payment.getLocalizedFormattedDate(context),
                              style: AppTheme.tajawal(
                                fontSize: 12,
                                color: AppTheme.gray500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${payment.amount.toStringAsFixed(2)}',
                      style: AppTheme.tajawal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      l10n.currency,
                      style: AppTheme.tajawal(
                        fontSize: 12,
                        color: AppTheme.gray500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Card Footer with Payment Method
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.paymentMethod,
                  style: AppTheme.tajawal(
                    fontSize: 13,
                    color: AppTheme.gray500,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: methodColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getPaymentMethodIcon(payment.paymentMethod),
                        size: 16,
                        color: methodColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        payment.getLocalizedPaymentMethod(context),
                        style: AppTheme.tajawal(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: methodColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPaymentMethodIcon(String method) {
    switch (method.toLowerCase()) {
      case 'cash':
        return Icons.payments;
      case 'card':
        return Icons.credit_card;
      case 'transfer':
        return Icons.account_balance;
      case 'check':
        return Icons.description;
      default:
        return Icons.payment;
    }
  }

  Color _getPaymentMethodColor(String method) {
    switch (method.toLowerCase()) {
      case 'cash':
        return Colors.green;
      case 'card':
        return Colors.blue;
      case 'transfer':
        return Colors.purple;
      case 'check':
        return Colors.orange;
      default:
        return AppTheme.gray600;
    }
  }
}
