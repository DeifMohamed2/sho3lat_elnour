import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class TabHeader extends StatelessWidget {
  final Map<String, dynamic>? student;
  final String title;
  final VoidCallback onShowStudentSelector;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;
  final int unreadNotificationsCount;

  const TabHeader({
    super.key,
    this.student,
    required this.title,
    required this.onShowStudentSelector,
    this.onProfileTap,
    this.onNotificationTap,
    this.unreadNotificationsCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.primaryBlue,
            AppTheme.primaryBlueDark,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        student?['avatar'] ?? '👦',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTheme.tajawal(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.white,
                        ),
                      ),
                      Text(
                        student?['name'] ?? 'محمد أحمد العلي',
                        style: AppTheme.tajawal(
                          fontSize: 14,
                          color: AppTheme.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.person_outline, color: AppTheme.white),
                    onPressed: onProfileTap,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined,
                            color: AppTheme.white),
                        onPressed: onNotificationTap,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      if (unreadNotificationsCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                unreadNotificationsCount > 9 ? '9+' : '$unreadNotificationsCount',
                                style: AppTheme.tajawal(
                                  fontSize: 10,
                                  color: AppTheme.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Student Selector
          Material(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: onShowStudentSelector,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppTheme.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          student?['avatar'] ?? '👦',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student?['name'] ?? 'محمد أحمد العلي',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.white,
                            ),
                          ),
                          Text(
                            '${student?['grade'] ?? 'الصف الخامس'} - ${student?['class'] ?? '5-أ'}',
                            style: AppTheme.tajawal(
                              fontSize: 12,
                              color: AppTheme.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppTheme.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

