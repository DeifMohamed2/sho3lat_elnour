import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/dashboard/dashboard_response.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/tab_header.dart';

class TimetableTab extends StatefulWidget {
  final Map<String, dynamic>? student;
  final DashboardResponse? dashboardResponse;
  final VoidCallback onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;
  final Future<void> Function()? onRefresh;

  const TimetableTab({
    super.key,
    this.student,
    this.dashboardResponse,
    required this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
    this.onRefresh,
  });

  @override
  State<TimetableTab> createState() => _TimetableTabState();
}

class _TimetableTabState extends State<TimetableTab> {
  bool _isDownloading = false;

  // Get schedule image URL from dashboard response
  String? get scheduleImageUrl {
    return widget.dashboardResponse?.selectedStudent?.classInfo?.scheduleImage;
  }

  Future<void> _downloadTimetable(BuildContext context, AppLocalizations l10n) async {
    if (_isDownloading) return;
    
    final imageUrl = scheduleImageUrl;
    if (imageUrl == null || imageUrl.isEmpty) {
      _showErrorSnackBar(context, l10n.noTimetableAvailable);
      return;
    }

    // Show permission explanation dialog first
    final shouldProceed = await _showPermissionDialog(context, l10n);
    if (!shouldProceed) {
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    try {
      // Show downloading message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.downloadingTimetable,
                    style: AppTheme.tajawal(fontSize: 14, color: AppTheme.white),
                  ),
                ),
              ],
            ),
            backgroundColor: AppTheme.primaryBlue,
            duration: const Duration(seconds: 30),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }

      // Download the image
      final dio = Dio();
      
      // Get temporary directory to save file first
      final tempDir = await getTemporaryDirectory();
      final tempFilePath = '${tempDir.path}/timetable_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // Download and save to temp file
      await dio.download(imageUrl, tempFilePath);

      // Save to gallery using gal package (handles permissions automatically)
      await Gal.putImage(tempFilePath);

      // Clean up temp file
      final tempFile = File(tempFilePath);
      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      if (mounted) {
        // Hide downloading message
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        
        // Show success message with guidance
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppTheme.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.timetableDownloaded,
                        style: AppTheme.tajawal(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.isArabic
                      ? 'يمكنك العثور عليه في تطبيق المعرض أو الصور'
                      : 'You can find it in your Gallery or Photos app',
                  style: AppTheme.tajawal(
                    fontSize: 12,
                    color: AppTheme.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } on GalException catch (e) {
      print('Gal error downloading timetable: ${e.type}');
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        
        if (e.type == GalExceptionType.accessDenied) {
          _showErrorSnackBar(
            context,
            l10n.isArabic 
              ? 'تم رفض إذن الوصول للمعرض. يرجى تفعيله من الإعدادات'
              : 'Gallery access denied. Please enable it in settings',
          );
        } else {
          _showErrorSnackBar(
            context,
            l10n.isArabic 
              ? 'فشل حفظ الجدول'
              : 'Failed to save timetable',
          );
        }
      }
    } catch (e) {
      print('Error downloading timetable: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        _showErrorSnackBar(
          context, 
          l10n.isArabic 
            ? 'حدث خطأ أثناء تحميل الجدول'
            : 'Error downloading timetable',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  Future<bool> _showPermissionDialog(BuildContext context, AppLocalizations l10n) async {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.photo_library, color: AppTheme.primaryBlue, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isRtl ? 'إذن الوصول للمعرض' : 'Gallery Access',
                  style: AppTheme.tajawal(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.gray800,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            isRtl
                ? 'نحتاج إلى إذن للوصول إلى معرض الصور لحفظ الجدول الدراسي على جهازك'
                : 'We need permission to access your photo gallery to save the timetable to your device',
            style: AppTheme.tajawal(
              fontSize: 14,
              color: AppTheme.gray600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                l10n.cancel,
                style: AppTheme.tajawal(
                  fontSize: 14,
                  color: AppTheme.gray600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: AppTheme.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isRtl ? 'موافق' : 'OK',
                style: AppTheme.tajawal(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    ) ?? false;
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppTheme.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
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

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: AppTheme.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTheme.tajawal(fontSize: 14, color: AppTheme.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final imageUrl = scheduleImageUrl;
    final unreadCount = widget.dashboardResponse?.notifications?.unreadCount ?? 0;

    return RefreshIndicator(
      onRefresh: widget.onRefresh ?? () async {},
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
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
                    unreadNotificationsCount: unreadCount,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Download Button (only show if image is available)
                        if (imageUrl != null && imageUrl.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ElevatedButton.icon(
                              onPressed:
                                  _isDownloading
                                      ? null
                                      : () => _downloadTimetable(context, l10n),
                              icon: _isDownloading
                                  ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppTheme.white,
                                      ),
                                    ),
                                  )
                                  : const Icon(Icons.download, size: 20),
                              label: Text(
                                _isDownloading
                                    ? l10n.downloadingTimetable
                                    : l10n.downloadTimetable,
                                style: AppTheme.tajawal(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                                foregroundColor: AppTheme.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                            ),
                          ),
                        // Image Viewer
                        Container(
                          height:
                              constraints.maxHeight -
                              200, // Approximate header + padding
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
                            child:
                                imageUrl != null && imageUrl.isNotEmpty
                                    ? InteractiveViewer(
                                      minScale: 0.5,
                                      maxScale: 4.0,
                                      child: Center(
                                        child: Image.network(
                                          imageUrl,
                                          fit: BoxFit.contain,
                                          loadingBuilder: (
                                            context,
                                            child,
                                            loadingProgress,
                                          ) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircularProgressIndicator(
                                                    value:
                                                        loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                    color: AppTheme.primaryBlue,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Text(
                                                    l10n.downloadingTimetable,
                                                    style: AppTheme.tajawal(
                                                      fontSize: 14,
                                                      color: AppTheme.gray600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          errorBuilder: (
                                            context,
                                            error,
                                            stackTrace,
                                          ) {
                                            return _buildNoScheduleWidget(l10n);
                                          },
                                        ),
                                      ),
                                    )
                                    : _buildNoScheduleWidget(l10n),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoScheduleWidget(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 64, color: AppTheme.gray400),
          const SizedBox(height: 16),
          Text(
            l10n.noTimetableAvailable,
            style: AppTheme.tajawal(fontSize: 16, color: AppTheme.gray600),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.timetableComingSoon,
            style: AppTheme.tajawal(fontSize: 12, color: AppTheme.gray400),
          ),
        ],
      ),
    );
  }
}
