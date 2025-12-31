import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class StudentSelectorWidget extends StatelessWidget {
  final Map<String, dynamic>? currentStudent;
  final List<Map<String, dynamic>>? students;
  final Function(Map<String, dynamic>) onSelectStudent;
  final VoidCallback onClose;

  const StudentSelectorWidget({
    super.key,
    this.currentStudent,
    this.students,
    required this.onSelectStudent,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    // Use provided students from API or fallback to empty list
    final studentsList = students ?? [];

    return Stack(
      children: [
        // Backdrop
        Positioned.fill(
          child: GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        // Bottom Sheet
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width > 500 ? 
                (MediaQuery.of(context).size.width - 500) / 2 : 0,
            ),
            decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.borderGray, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onClose,
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.gray200,
                        ),
                      ),
                      Text(
                        'اختر الطالب',
                        style: AppTheme.tajawal(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gray800,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                // Students List
                Flexible(
                  child: studentsList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_off,
                                  size: 48,
                                  color: AppTheme.gray400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'لا يوجد طلاب',
                                  style: AppTheme.tajawal(
                                    fontSize: 16,
                                    color: AppTheme.gray600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(24),
                          itemCount: studentsList.length,
                          itemBuilder: (context, index) {
                            final student = studentsList[index];
                            final isSelected = currentStudent?['id'] == student['id'];
                            final isBlocked = student['isBlocked'] == true;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Material(
                                color: isSelected
                                    ? AppTheme.primaryBlue
                                    : isBlocked
                                        ? Colors.red.shade50
                                        : AppTheme.backgroundLight,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  onTap: isBlocked ? null : () => onSelectStudent(student),
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 56,
                                          height: 56,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppTheme.white.withOpacity(0.2)
                                                : AppTheme.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              student['avatar'] as String? ?? '👦',
                                              style: const TextStyle(fontSize: 28),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                student['name'] as String? ?? '',
                                                style: AppTheme.tajawal(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: isSelected
                                                      ? AppTheme.white
                                                      : isBlocked
                                                          ? Colors.red.shade700
                                                          : AppTheme.gray800,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${student['grade'] as String? ?? ''} - ${student['class'] as String? ?? ''}',
                                                style: AppTheme.tajawal(
                                                  fontSize: 14,
                                                  color: isSelected
                                                      ? AppTheme.white.withOpacity(0.8)
                                                      : AppTheme.gray500,
                                                ),
                                              ),
                                              if (isBlocked) ...[
                                                const SizedBox(height: 4),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 2,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.shade100,
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    'محظور',
                                                    style: AppTheme.tajawal(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.red.shade700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                        if (isSelected)
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: const BoxDecoration(
                                              color: AppTheme.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.check,
                                                size: 16,
                                                color: AppTheme.primaryBlue,
                                              ),
                                            ),
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

