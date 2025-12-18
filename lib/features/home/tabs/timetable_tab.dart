import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/tab_header.dart';

class TimetableTab extends StatefulWidget {
  final Map<String, dynamic>? student;
  final VoidCallback onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;

  const TimetableTab({
    super.key,
    this.student,
    required this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
  });

  @override
  State<TimetableTab> createState() => _TimetableTabState();
}

class _TimetableTabState extends State<TimetableTab> {
  String _selectedDay = 'الأربعاء';

  final List<String> _weekDays = ['الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];

  final Map<String, List<Map<String, dynamic>>> _timetable = {
    'الأحد': [
      {'subject': 'القرآن الكريم', 'time': '7:30 - 8:15', 'teacher': 'أ. أحمد محمد', 'color': Colors.green},
      {'subject': 'الرياضيات', 'time': '8:15 - 9:00', 'teacher': 'أ. خالد سالم', 'color': Colors.blue},
      {'subject': 'اللغة العربية', 'time': '9:00 - 9:45', 'teacher': 'أ. فاطمة علي', 'color': Colors.red},
      {'subject': 'استراحة', 'time': '9:45 - 10:00', 'teacher': '', 'color': AppTheme.gray300},
      {'subject': 'العلوم', 'time': '10:00 - 10:45', 'teacher': 'أ. سارة أحمد', 'color': Colors.teal},
      {'subject': 'التربية البدنية', 'time': '10:45 - 11:30', 'teacher': 'أ. عمر حسن', 'color': Colors.orange},
    ],
    'الإثنين': [
      {'subject': 'اللغة الإنجليزية', 'time': '7:30 - 8:15', 'teacher': 'أ. نورا سعيد', 'color': Colors.purple},
      {'subject': 'الرياضيات', 'time': '8:15 - 9:00', 'teacher': 'أ. خالد سالم', 'color': Colors.blue},
      {'subject': 'العلوم', 'time': '9:00 - 9:45', 'teacher': 'أ. سارة أحمد', 'color': Colors.teal},
      {'subject': 'استراحة', 'time': '9:45 - 10:00', 'teacher': '', 'color': AppTheme.gray300},
      {'subject': 'الاجتماعيات', 'time': '10:00 - 10:45', 'teacher': 'أ. محمود علي', 'color': Colors.amber},
      {'subject': 'التربية الفنية', 'time': '10:45 - 11:30', 'teacher': 'أ. ليلى حسن', 'color': Colors.pink},
    ],
    'الثلاثاء': [
      {'subject': 'القرآن الكريم', 'time': '7:30 - 8:15', 'teacher': 'أ. أحمد محمد', 'color': Colors.green},
      {'subject': 'اللغة العربية', 'time': '8:15 - 9:00', 'teacher': 'أ. فاطمة علي', 'color': Colors.red},
      {'subject': 'الرياضيات', 'time': '9:00 - 9:45', 'teacher': 'أ. خالد سالم', 'color': Colors.blue},
      {'subject': 'استراحة', 'time': '9:45 - 10:00', 'teacher': '', 'color': AppTheme.gray300},
      {'subject': 'اللغة الإنجليزية', 'time': '10:00 - 10:45', 'teacher': 'أ. نورا سعيد', 'color': Colors.purple},
      {'subject': 'الحاسب الآلي', 'time': '10:45 - 11:30', 'teacher': 'أ. ياسر خالد', 'color': Colors.indigo},
    ],
    'الأربعاء': [
      {'subject': 'اللغة العربية', 'time': '7:30 - 8:15', 'teacher': 'أ. فاطمة علي', 'color': Colors.red},
      {'subject': 'العلوم', 'time': '8:15 - 9:00', 'teacher': 'أ. سارة أحمد', 'color': Colors.teal},
      {'subject': 'الرياضيات', 'time': '9:00 - 9:45', 'teacher': 'أ. خالد سالم', 'color': Colors.blue},
      {'subject': 'استراحة', 'time': '9:45 - 10:00', 'teacher': '', 'color': AppTheme.gray300},
      {'subject': 'الاجتماعيات', 'time': '10:00 - 10:45', 'teacher': 'أ. محمود علي', 'color': Colors.amber},
      {'subject': 'التربية الموسيقية', 'time': '10:45 - 11:30', 'teacher': 'أ. هدى محمد', 'color': Colors.cyan},
    ],
    'الخميس': [
      {'subject': 'القرآن الكريم', 'time': '7:30 - 8:15', 'teacher': 'أ. أحمد محمد', 'color': Colors.green},
      {'subject': 'اللغة الإنجليزية', 'time': '8:15 - 9:00', 'teacher': 'أ. نورا سعيد', 'color': Colors.purple},
      {'subject': 'العلوم', 'time': '9:00 - 9:45', 'teacher': 'أ. سارة أحمد', 'color': Colors.teal},
      {'subject': 'استراحة', 'time': '9:45 - 10:00', 'teacher': '', 'color': AppTheme.gray300},
      {'subject': 'الرياضيات', 'time': '10:00 - 10:45', 'teacher': 'أ. خالد سالم', 'color': Colors.blue},
      {'subject': 'التربية البدنية', 'time': '10:45 - 11:30', 'teacher': 'أ. عمر حسن', 'color': Colors.orange},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final todayClasses = _timetable[_selectedDay] ?? [];
    final classCount = todayClasses.where((c) => c['subject'] != 'استراحة').length;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabHeader(
            student: widget.student,
            title: widget.title,
            onShowStudentSelector: widget.onShowStudentSelector,
            onProfileTap: widget.onProfileTap,
            onNotificationTap: () => Navigator.of(context).pushNamed('/notifications'),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
          // Current Class
          Container(
            padding: const EdgeInsets.all(20),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, color: AppTheme.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'الحصة الحالية',
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        color: AppTheme.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'الرياضيات',
                  style: AppTheme.tajawal(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'أ. خالد سالم',
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    color: AppTheme.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: AppTheme.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '8:00 - 8:45',
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        color: AppTheme.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Day Selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _weekDays.map((day) {
                final isSelected = _selectedDay == day;
                return Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setState(() => _selectedDay = day),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primaryBlue : AppTheme.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppTheme.primaryBlue.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          day,
                          style: AppTheme.tajawal(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? AppTheme.white : AppTheme.gray600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Timetable
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
                      'جدول يوم $_selectedDay',
                      style: AppTheme.tajawal(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.gray700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...todayClasses.map((classItem) {
                  final isBreak = classItem['subject'] == 'استراحة';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: isBreak ? AppTheme.gray50 : AppTheme.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isBreak
                            ? AppTheme.gray300
                            : (classItem['color'] as Color).withOpacity(0.3),
                        width: 2,
                        style: isBreak ? BorderStyle.solid : BorderStyle.solid,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          decoration: BoxDecoration(
                            color: classItem['color'] as Color,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        classItem['subject'] as String,
                                        style: AppTheme.tajawal(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.gray800,
                                        ),
                                      ),
                                      if (classItem['teacher'] != null && classItem['teacher'].toString().isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Text(
                                            classItem['teacher'] as String,
                                            style: AppTheme.tajawal(
                                              fontSize: 12,
                                              color: AppTheme.gray500,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isBreak
                                        ? AppTheme.gray200
                                        : AppTheme.primaryBlue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    classItem['time'] as String,
                                    style: AppTheme.tajawal(
                                      fontSize: 12,
                                      color: isBreak ? AppTheme.gray600 : AppTheme.primaryBlue,
                                    ),
                                  ),
                                ),
                              ],
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
          // Summary
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
                  'ملخص اليوم',
                  style: AppTheme.tajawal(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.gray700,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  children: [
                    _buildSummaryItem('عدد الحصص', '$classCount'),
                    _buildSummaryItem('وقت البداية', '7:30 ص'),
                    _buildSummaryItem('وقت الانتهاء', '11:30 ص'),
                    _buildSummaryItem('مدة الاستراحة', '15 د'),
                  ],
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

  Widget _buildSummaryItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTheme.tajawal(
              fontSize: 12,
              color: AppTheme.gray500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTheme.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.gray800,
            ),
          ),
        ],
      ),
    );
  }
}
