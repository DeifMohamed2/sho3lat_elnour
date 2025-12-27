import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/tab_header.dart';

class TimetableTab extends StatelessWidget {
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

  // TODO: Update this path to your actual timetable image
  // You can place the image in assets/ folder and update pubspec.yaml
  // For now, using a placeholder - replace with actual image path
  static const String timetableImagePath = 'assets/icons/calendar.png';

  void _downloadTimetable(BuildContext context) {
    // TODO: Implement actual download functionality
    // You may need to add packages like:
    // - image_gallery_saver: ^2.0.3 (for saving images)
    // - permission_handler: ^11.0.0 (for permissions)
    // - path_provider: ^2.1.0 (for file paths)

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppTheme.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'تم تحميل الجدول بنجاح',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabHeader(
          student: student,
          title: title,
          onShowStudentSelector: onShowStudentSelector,
          onProfileTap: onProfileTap,
          onNotificationTap:
              () => Navigator.of(context).pushNamed('/notifications'),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Download Button
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton.icon(
                    onPressed: () => _downloadTimetable(context),
                    icon: const Icon(Icons.download, size: 20),
                    label: Text(
                      'تحميل الجدول',
                      style: AppTheme.tajawal(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: AppTheme.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
                // Image Viewer
                Expanded(
                  child: Container(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: InteractiveViewer(
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: Center(
                          child: Image.asset(
                            timetableImagePath,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 64,
                                    color: AppTheme.gray400,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'لا يوجد جدول متاح حالياً',
                                    style: AppTheme.tajawal(
                                      fontSize: 16,
                                      color: AppTheme.gray600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'يرجى تحديث مسار الصورة في الكود',
                                    style: AppTheme.tajawal(
                                      fontSize: 12,
                                      color: AppTheme.gray400,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
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
