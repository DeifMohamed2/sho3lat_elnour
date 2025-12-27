import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ParentProfileScreen extends StatelessWidget {
  const ParentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parentData = {'name': 'أحمد محمد العلي', 'phone': '+966 50 123 4567'};

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        body: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.primaryBlue.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppTheme.gray600,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'ملفي',
                    style: AppTheme.tajawal(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.gray800,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  children: [
                    // Parent Info Card
                    Container(
                      padding: const EdgeInsets.all(24),
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
                          Text(
                            parentData['name'] as String,
                            style: AppTheme.tajawal(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.gray800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ولي أمر',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray500,
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildContactInfo(
                            Icons.phone,
                            'رقم الهاتف',
                            parentData['phone'] as String,
                            Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Children Section
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.people,
                                    color: AppTheme.primaryBlue,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'الأبناء',
                                    style: AppTheme.tajawal(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.gray700,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed:
                                    () => Navigator.of(
                                      context,
                                    ).pushNamed('/manageChildren'),
                                child: Text(
                                  'إدارة الكل',
                                  style: AppTheme.tajawal(
                                    fontSize: 14,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildChildCard(
                            'محمد أحمد العلي',
                            'الصف الخامس',
                            '5-أ',
                            '👦',
                            () {
                              Navigator.of(context).pushReplacementNamed(
                                '/main',
                                arguments: {
                                  'student': {
                                    'id': 1,
                                    'name': 'محمد أحمد العلي',
                                    'grade': 'الصف الخامس',
                                    'class': '5-أ',
                                    'avatar': '👦',
                                    'studentId': 'STD-2024-1234',
                                  },
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          _buildChildCard(
                            'فاطمة أحمد العلي',
                            'الصف الثاني',
                            '2-ب',
                            '👧',
                            () {
                              Navigator.of(context).pushReplacementNamed(
                                '/main',
                                arguments: {
                                  'student': {
                                    'id': 2,
                                    'name': 'فاطمة أحمد العلي',
                                    'grade': 'الصف الثاني',
                                    'class': '2-ب',
                                    'avatar': '👧',
                                    'studentId': 'STD-2024-5678',
                                  },
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Quick Actions
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
                            'إجراءات سريعة',
                            style: AppTheme.tajawal(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.gray700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildQuickAction(
                            Icons.people,
                            'إدارة الأبناء',
                            () => Navigator.of(
                              context,
                            ).pushNamed('/manageChildren'),
                          ),
                          _buildQuickAction(
                            Icons.settings,
                            'الإعدادات',
                            () => Navigator.of(context).pushNamed('/settings'),
                          ),
                          _buildQuickAction(
                            Icons.info_outline,
                            'حول التطبيق',
                            () => Navigator.of(context).pushNamed('/aboutApp'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
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
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.tajawal(
                    fontSize: 12,
                    color: AppTheme.gray500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTheme.tajawal(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.gray800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildCard(
    String name,
    String grade,
    String className,
    String avatar,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(avatar, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.gray800,
                      ),
                    ),
                    Text(
                      '$grade - $className',
                      style: AppTheme.tajawal(
                        fontSize: 12,
                        color: AppTheme.gray500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppTheme.gray400),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.primaryBlue, size: 20),
              const SizedBox(width: 12),
              Text(
                label,
                style: AppTheme.tajawal(fontSize: 14, color: AppTheme.gray800),
              ),
              const Spacer(),
              const Icon(
                Icons.chevron_right,
                color: AppTheme.gray400,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
