import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'tabs/home_tab.dart';
import 'tabs/attendance_tab.dart';
import 'tabs/timetable_tab.dart';
import 'tabs/grades_tab.dart';
import 'tabs/messages_tab.dart';
import 'widgets/student_selector_widget.dart';

class MainLayout extends StatefulWidget {
  final Map<String, dynamic>? student;

  const MainLayout({
    super.key,
    this.student,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  bool _showStudentSelector = false;

  final List<Map<String, dynamic>> _tabs = [
    {'id': 0, 'label': 'الرئيسية', 'iconPath': 'assets/icons/home.png'},
    {'id': 1, 'label': 'الحضور', 'iconPath': 'assets/icons/check-mark.png'},
    {'id': 2, 'label': 'الجدول', 'iconPath': 'assets/icons/calendar.png'},
    {'id': 3, 'label': 'الشهادات', 'iconPath': 'assets/icons/certificate.png'},
    {'id': 4, 'label': 'الرسائل', 'iconPath': 'assets/icons/messages.png'},
  ];

  Widget _buildTabContent() {
    switch (_currentIndex) {
      case 0:
        return HomeTab(
          student: widget.student,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
          onSwitchTab: (index) => setState(() => _currentIndex = index),
        );
      case 1:
        return AttendanceTab(
          student: widget.student,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
        );
      case 2:
        return TimetableTab(
          student: widget.student,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
        );
      case 3:
        return GradesTab(
          student: widget.student,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
        );
      case 4:
        return MessagesTab(
          student: widget.student,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
        );
      default:
        return HomeTab(
          student: widget.student,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
        );
    }
  }

  String _getTabTitle() {
    switch (_currentIndex) {
      case 0:
        return 'الرئيسية';
      case 1:
        return 'الحضور';
      case 2:
        return 'الجدول';
      case 3:
        return 'الشهادات';
      case 4:
        return 'الرسائل';
      default:
        return 'الرئيسية';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: _buildTabContent(),
                ),
                // Bottom Navigation
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border(
                      top: BorderSide(color: AppTheme.borderGray, width: 1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _tabs.map((tab) {
                          final isActive = _currentIndex == tab['id'];
                          return Expanded(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => setState(() => _currentIndex = tab['id']),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? AppTheme.primaryBlue.withOpacity(0.1)
                                              : Colors.transparent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          tab['iconPath'] as String,
                                          width: 20,
                                          height: 20,
                                          color: isActive
                                              ? AppTheme.primaryBlue
                                              : AppTheme.textGray,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        tab['label'],
                                        style: AppTheme.tajawal(
                                          fontSize: 10,
                                          color: isActive
                                              ? AppTheme.primaryBlue
                                              : AppTheme.textGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Student Selector Widget
            if (_showStudentSelector)
              StudentSelectorWidget(
                currentStudent: widget.student,
                onSelectStudent: (student) {
                  setState(() {
                    _showStudentSelector = false;
                  });
                  Navigator.of(context).pushReplacementNamed('/main', arguments: {'student': student});
                },
                onClose: () => setState(() => _showStudentSelector = false),
              ),
          ],
        ),
      ),
    );
  }
}

