import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/tab_header.dart';

class GradesTab extends StatelessWidget {
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

  Map<String, dynamic> _getGradeStatus(int grade) {
    if (grade >= 90) {
      return {'text': 'ممتاز', 'color': Colors.green, 'bg': Colors.green.shade100};
    } else if (grade >= 80) {
      return {'text': 'جيد جداً', 'color': Colors.blue, 'bg': Colors.blue.shade100};
    } else if (grade >= 70) {
      return {'text': 'جيد', 'color': Colors.yellow, 'bg': Colors.yellow.shade100};
    } else if (grade >= 60) {
      return {'text': 'مقبول', 'color': Colors.orange, 'bg': Colors.orange.shade100};
    } else {
      return {'text': 'ضعيف', 'color': Colors.red, 'bg': Colors.red.shade100};
    }
  }

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {'name': 'القرآن الكريم', 'grade': 95, 'color': Colors.green},
      {'name': 'الرياضيات', 'grade': 88, 'color': Colors.blue},
      {'name': 'اللغة العربية', 'grade': 92, 'color': Colors.red},
      {'name': 'العلوم', 'grade': 85, 'color': Colors.teal},
      {'name': 'اللغة الإنجليزية', 'grade': 90, 'color': Colors.purple},
      {'name': 'الاجتماعيات', 'grade': 87, 'color': Colors.amber},
      {'name': 'التربية الفنية', 'grade': 94, 'color': Colors.pink},
      {'name': 'التربية البدنية', 'grade': 91, 'color': Colors.orange},
    ];

    final totalAverage = (subjects.map((s) => s['grade'] as int).reduce((a, b) => a + b) / subjects.length).round();
    final overallStatus = _getGradeStatus(totalAverage);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabHeader(
            student: student,
            title: title,
            onShowStudentSelector: onShowStudentSelector,
            onProfileTap: onProfileTap,
            onNotificationTap: () => Navigator.of(context).pushNamed('/notifications'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
          // Overall Performance
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المعدل العام',
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        color: AppTheme.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$totalAverage%',
                      style: AppTheme.tajawal(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.trending_up, color: AppTheme.white, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'أداء ${overallStatus['text']}',
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            color: AppTheme.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.school, color: AppTheme.white, size: 40),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Performance Graph
          Container(
            padding: const EdgeInsets.all(20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الأداء الدراسي',
                  style: AppTheme.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.gray700,
                  ),
                ),
                const SizedBox(height: 16),
                ...subjects.take(5).map((subject) {
                  final grade = subject['grade'] as int;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              subject['name'] as String,
                              style: AppTheme.tajawal(
                                fontSize: 14,
                                color: AppTheme.gray700,
                              ),
                            ),
                            Text(
                              '$grade%',
                              style: AppTheme.tajawal(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.gray800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppTheme.gray100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerRight,
                            widthFactor: grade / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: subject['color'] as Color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Subjects List
          Container(
            padding: const EdgeInsets.all(20),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.book, color: AppTheme.primaryBlue, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'جميع المواد',
                      style: AppTheme.tajawal(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.gray700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...subjects.map((subject) {
                  final grade = subject['grade'] as int;
                  final status = _getGradeStatus(grade);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: subject['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.book, color: AppTheme.white, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                subject['name'] as String,
                                style: AppTheme.tajawal(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.gray800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: status['bg'] as Color,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  status['text'] as String,
                                  style: AppTheme.tajawal(
                                    fontSize: 10,
                                    color: status['color'] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$grade',
                              style: AppTheme.tajawal(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.gray800,
                              ),
                            ),
                            Text(
                              'من 100',
                              style: AppTheme.tajawal(
                                fontSize: 12,
                                color: AppTheme.gray400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Certificate Download
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.amber.shade50, Colors.yellow.shade50],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber.shade200, width: 2),
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
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.school, color: AppTheme.white, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الشهادة الفصلية',
                            style: AppTheme.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.gray800,
                            ),
                          ),
                          Text(
                            'الفصل الدراسي الأول 2024',
                            style: AppTheme.tajawal(
                              fontSize: 12,
                              color: AppTheme.gray600,
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
                    onPressed: () {
                      // Simulate certificate download
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle, color: AppTheme.white),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'تم تحميل الشهادة بنجاح',
                                  style: AppTheme.tajawal(
                                    fontSize: 14,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
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
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
          ),
          const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }
}
