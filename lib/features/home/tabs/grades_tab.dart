import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/dashboard/dashboard_response.dart';
import '../../../core/models/dashboard/certificates_info.dart';
import '../widgets/tab_header.dart';

class GradesTab extends StatefulWidget {
  final Map<String, dynamic>? student;
  final DashboardResponse? dashboardResponse;
  final VoidCallback onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;
  final Future<void> Function()? onRefresh;

  const GradesTab({
    super.key,
    this.student,
    this.dashboardResponse,
    required this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
    this.onRefresh,
  });

  @override
  State<GradesTab> createState() => _GradesTabState();
}

class _GradesTabState extends State<GradesTab> {
  final Map<String, bool> _expandedCertificates = {};

  List<Certificate> get _certificates {
    return widget.dashboardResponse?.certificates?.list ?? [];
  }

  Future<void> _downloadCertificate(BuildContext context, Certificate certificate) async {
    // Check if certificate is locked
    if (certificate.isLocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.lock, color: AppTheme.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'هذه الشهادة مقفلة حالياً',
                  style: AppTheme.tajawal(fontSize: 14, color: AppTheme.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    if (certificate.fileUrl == null || certificate.fileUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: AppTheme.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'الملف غير متاح حالياً',
                  style: AppTheme.tajawal(fontSize: 14, color: AppTheme.white),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    try {
      final uri = Uri.parse(certificate.fileUrl!);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppTheme.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'جاري فتح الشهادة...',
                      style: AppTheme.tajawal(fontSize: 14, color: AppTheme.white),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: AppTheme.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'حدث خطأ أثناء فتح الشهادة',
                    style: AppTheme.tajawal(fontSize: 14, color: AppTheme.white),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = widget.dashboardResponse?.notifications?.unreadCount ?? 0;
    
    return RefreshIndicator(
      onRefresh: widget.onRefresh ?? () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabHeader(
            student: widget.student,
            title: widget.title,
            onShowStudentSelector: widget.onShowStudentSelector,
            onProfileTap: widget.onProfileTap,
            onNotificationTap:
                () => Navigator.of(context).pushNamed('/notifications'),
            unreadNotificationsCount: unreadCount,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_certificates.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.school_outlined,
                          size: 64,
                          color: AppTheme.gray400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد شهادات متاحة',
                          style: AppTheme.tajawal(
                            fontSize: 16,
                            color: AppTheme.gray600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'سيتم إضافة الشهادات عند توفرها',
                          style: AppTheme.tajawal(
                            fontSize: 12,
                            color: AppTheme.gray400,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ..._certificates.map((certificate) {
                    final certificateId = certificate.id;
                    final isExpanded =
                        _expandedCertificates[certificateId] ?? false;
                    final isLocked = certificate.isLocked;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: isLocked ? AppTheme.gray100 : AppTheme.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        initiallyExpanded: isExpanded,
                        onExpansionChanged: (expanded) {
                          setState(() {
                            _expandedCertificates[certificateId] = expanded;
                          });
                        },
                        leading: Stack(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isLocked ? AppTheme.gray400 : Colors.amber,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isLocked ? Icons.lock : Icons.school,
                                color: AppTheme.white,
                                size: 20,
                              ),
                            ),
                            if (isLocked)
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppTheme.white, width: 2),
                                  ),
                                  child: const Icon(
                                    Icons.lock,
                                    color: AppTheme.white,
                                    size: 8,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                certificate.title,
                                style: AppTheme.tajawal(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isLocked ? AppTheme.gray500 : AppTheme.gray700,
                                ),
                              ),
                            ),
                            if (isLocked)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'مقفلة',
                                  style: AppTheme.tajawal(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        subtitle: Text(
                          certificate.certificateTypeName ?? certificate.certificateType,
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            color: isLocked ? AppTheme.gray400 : AppTheme.gray500,
                          ),
                        ),
                        trailing: Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppTheme.primaryBlue,
                        ),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: isLocked
                                    ? [AppTheme.gray100, AppTheme.gray200]
                                    : [Colors.amber.shade50, Colors.yellow.shade50],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isLocked ? AppTheme.gray300 : Colors.amber.shade200,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: isLocked ? AppTheme.gray400 : Colors.amber,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isLocked ? Icons.lock : Icons.school,
                                        color: AppTheme.white,
                                        size: 32,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            certificate.title,
                                            style: AppTheme.tajawal(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.gray800,
                                            ),
                                          ),
                                          if (certificate.description != null) ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              certificate.description!,
                                              style: AppTheme.tajawal(
                                                fontSize: 12,
                                                color: AppTheme.gray600,
                                              ),
                                            ),
                                          ],
                                          if (certificate.academicYear != null) ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              '${certificate.academicYear}${certificate.semester != null ? ' - ${certificate.semesterArabic}' : ''}',
                                              style: AppTheme.tajawal(
                                                fontSize: 12,
                                                color: AppTheme.gray500,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (isLocked) ...[
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.red.shade200),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.lock, color: Colors.red, size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            'هذه الشهادة مقفلة حالياً. يرجى التواصل مع إدارة المدرسة لفتحها.',
                                            style: AppTheme.tajawal(
                                              fontSize: 12,
                                              color: Colors.red.shade700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ] else ...[
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () => _downloadCertificate(context, certificate),
                                      icon: Icon(
                                        certificate.isPdf ? Icons.picture_as_pdf : Icons.download,
                                        size: 20,
                                      ),
                                      label: Text(
                                        'تحميل الشهادة',
                                        style: AppTheme.tajawal(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                        foregroundColor: AppTheme.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
      ),
    );
  }
}
