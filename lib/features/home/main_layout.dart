import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/dashboard_provider.dart';
import 'tabs/home_tab.dart';
import 'tabs/attendance_tab.dart';
import 'tabs/timetable_tab.dart';
import 'tabs/grades_tab.dart';
import 'tabs/financial_tab.dart';
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
  final DashboardProvider _dashboardProvider = DashboardProvider();

  final List<Map<String, dynamic>> _tabs = [
    {'id': 0, 'label': 'الرئيسية', 'iconPath': 'assets/icons/home.png'},
    {'id': 1, 'label': 'الحضور', 'iconPath': 'assets/icons/check-mark.png'},
    {'id': 2, 'label': 'الجدول', 'iconPath': 'assets/icons/calendar.png'},
    {'id': 3, 'label': 'الشهادات', 'iconPath': 'assets/icons/certificate.png'},
    {'id': 4, 'label': 'المالية', 'iconPath': 'assets/icons/money.png'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeDashboard();
  }

  Future<void> _initializeDashboard() async {
    // Get the student ID from the passed student data or use the stored one
    final studentId = widget.student?['id']?.toString();
    
    print('🚀 [MAIN_LAYOUT] Initializing dashboard with student ID: $studentId');
    
    await _dashboardProvider.loadDashboard(studentId: studentId);
    
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _onRefresh() async {
    await _dashboardProvider.refresh();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _onStudentSelected(Map<String, dynamic> student) async {
    setState(() {
      _showStudentSelector = false;
    });
    
    final studentId = student['id']?.toString();
    if (studentId != null) {
      // Show loading state immediately
      setState(() {});
      
      // Reload dashboard with new student
      await _dashboardProvider.switchStudent(studentId);
      
      if (mounted) {
        setState(() {});
      }
    }
  }

  Map<String, dynamic>? get _currentStudent {
    // Prefer dashboard data, fallback to widget data
    return _dashboardProvider.currentStudentMap ?? widget.student;
  }

  Widget _buildTabContent() {
    final student = _currentStudent;
    final dashboardResponse = _dashboardProvider.dashboardResponse;
    
    switch (_currentIndex) {
      case 0:
        return HomeTab(
          student: student,
          dashboardResponse: dashboardResponse,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
          onSwitchTab: (index) => setState(() => _currentIndex = index),
          onRefresh: _onRefresh,
        );
      case 1:
        return AttendanceTab(
          student: student,
          dashboardResponse: dashboardResponse,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
          onRefresh: _onRefresh,
        );
      case 2:
        return TimetableTab(
          student: student,
          dashboardResponse: dashboardResponse,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
          onRefresh: _onRefresh,
        );
      case 3:
        return GradesTab(
          student: student,
          dashboardResponse: dashboardResponse,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
          onRefresh: _onRefresh,
        );
      case 4:
        return FinancialTab(
          student: student,
          dashboardResponse: dashboardResponse,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
          onRefresh: _onRefresh,
        );
      default:
        return HomeTab(
          student: student,
          dashboardResponse: dashboardResponse,
          onShowStudentSelector: () => setState(() => _showStudentSelector = true),
          title: _getTabTitle(),
          onProfileTap: () => Navigator.of(context).pushNamed('/parentProfile'),
          onRefresh: _onRefresh,
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
        return 'المالية';
      default:
        return 'الرئيسية';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = _dashboardProvider.isLoading;
    
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
            // Loading Overlay
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ),
              ),
            // Student Selector Widget
            if (_showStudentSelector)
              StudentSelectorWidget(
                currentStudent: _currentStudent,
                students: _dashboardProvider.studentsMap,
                onSelectStudent: _onStudentSelected,
                onClose: () => setState(() => _showStudentSelector = false),
              ),
          ],
        ),
      ),
    );
  }
}

