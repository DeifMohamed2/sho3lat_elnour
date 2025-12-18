import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SelectStudentScreen extends StatefulWidget {
  const SelectStudentScreen({super.key});

  @override
  State<SelectStudentScreen> createState() => _SelectStudentScreenState();
}

class _SelectStudentScreenState extends State<SelectStudentScreen> {
  final List<Map<String, dynamic>> _students = [
    {
      'id': 1,
      'name': 'محمد أحمد العلي',
      'grade': 'الصف الخامس',
      'class': 'الفصل 5-أ',
      'avatar': '👦',
    },
    {
      'id': 2,
      'name': 'سارة أحمد العلي',
      'grade': 'الصف الثالث',
      'class': 'الفصل 3-ب',
      'avatar': '👧',
    },
  ];

  void _selectStudent(Map<String, dynamic> student) {
    Navigator.of(context).pushReplacementNamed('/main', arguments: {'student': student});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'اختر الطالب',
                  style: AppTheme.tajawal(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.gray800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'اختر من قائمة أبنائك لمتابعة أدائهم الدراسي',
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    color: AppTheme.gray500,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.builder(
                    itemCount: _students.length,
                    itemBuilder: (context, index) {
                      final student = _students[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Material(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16),
                          child: InkWell(
                            onTap: () => _selectStudent(student),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppTheme.primaryBlue,
                                          AppTheme.primaryBlueDark,
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        student['avatar'],
                                        style: const TextStyle(fontSize: 32),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          student['name'],
                                          style: AppTheme.tajawal(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.gray800,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Wrap(
                                          spacing: 8,
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              student['grade'],
                                              style: AppTheme.tajawal(
                                                fontSize: 14,
                                                color: AppTheme.gray500,
                                              ),
                                            ),
                                            Container(
                                              width: 4,
                                              height: 4,
                                              decoration: const BoxDecoration(
                                                color: AppTheme.gray300,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Text(
                                              student['class'],
                                              style: AppTheme.tajawal(
                                                fontSize: 14,
                                                color: AppTheme.gray500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_left,
                                    color: AppTheme.gray400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'يمكنك التبديل بين الطلاب في أي وقت من الملف الشخصي',
                  style: AppTheme.tajawal(
                    fontSize: 12,
                    color: AppTheme.gray400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
