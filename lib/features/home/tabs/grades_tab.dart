import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/tab_header.dart';

class GradesTab extends StatefulWidget {
  final Map<String, dynamic>? student;
  final VoidCallback onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;

  const GradesTab({
    super.key,
    this.student,
    required this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
  });

  @override
  State<GradesTab> createState() => _GradesTabState();
}

class _GradesTabState extends State<GradesTab> {
  final Map<String, bool> _expandedCertificates = {};

  // List of certificates - you can modify this to fetch from API
  final List<Map<String, dynamic>> _certificates = [
    {
      'id': 'cert_1',
      'title': 'الشهادة الفصلية',
      'subtitle': 'الفصل الدراسي الأول 2024',
      'date': 'يناير 2024',
    },
    {
      'id': 'cert_2',
      'title': 'الشهادة الفصلية',
      'subtitle': 'الفصل الدراسي الثاني 2024',
      'date': 'مايو 2024',
    },
    {
      'id': 'cert_3',
      'title': 'شهادة التقدير',
      'subtitle': 'للتميز في الأداء الدراسي',
      'date': 'يونيو 2024',
    },
    {
      'id': 'cert_4',
      'title': 'الشهادة السنوية',
      'subtitle': 'العام الدراسي 2023-2024',
      'date': 'يوليو 2024',
    },
  ];

  void _downloadCertificate(BuildContext context, String certificateId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppTheme.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'تم تحميل الشهادة بنجاح',
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ..._certificates.map((certificate) {
                  final certificateId = certificate['id'] as String;
                  final isExpanded =
                      _expandedCertificates[certificateId] ?? false;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
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
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.school,
                          color: AppTheme.white,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        certificate['title'] as String,
                        style: AppTheme.tajawal(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.gray700,
                        ),
                      ),
                      subtitle: Text(
                        certificate['subtitle'] as String,
                        style: AppTheme.tajawal(
                          fontSize: 14,
                          color: AppTheme.gray500,
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
                              colors: [
                                Colors.amber.shade50,
                                Colors.yellow.shade50,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.amber.shade200,
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
                                      color: Colors.amber,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.school,
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
                                          certificate['title'] as String,
                                          style: AppTheme.tajawal(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.gray800,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          certificate['subtitle'] as String,
                                          style: AppTheme.tajawal(
                                            fontSize: 12,
                                            color: AppTheme.gray600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          certificate['date'] as String,
                                          style: AppTheme.tajawal(
                                            fontSize: 12,
                                            color: AppTheme.gray500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed:
                                      () => _downloadCertificate(
                                        context,
                                        certificateId,
                                      ),
                                  icon: const Icon(Icons.download, size: 20),
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
    );
  }
}
