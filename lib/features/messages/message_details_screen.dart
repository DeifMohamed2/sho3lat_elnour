import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/localization/app_localizations.dart';

class MessageDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? message;

  const MessageDetailsScreen({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (message == null) {
      return Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        body: Center(
          child: Text(
            l10n.messageNotFound,
            style: AppTheme.tajawal(
              fontSize: 16,
              color: AppTheme.gray500,
            ),
          ),
        ),
      );
    }

    final isSchool = message!['type'] == 'school';

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: AppTheme.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    l10n.messageDetails,
                    style: AppTheme.tajawal(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Sender Info
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
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: isSchool ? Colors.blue.shade100 : Colors.purple.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    message!['icon'] as String,
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
                                      message!['from'] as String,
                                      style: AppTheme.tajawal(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.gray800,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today, size: 14, color: AppTheme.gray500),
                                        const SizedBox(width: 4),
                                        Text(
                                          message!['date'] as String,
                                          style: AppTheme.tajawal(
                                            fontSize: 12,
                                            color: AppTheme.gray500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSchool ? Colors.blue.shade50 : Colors.purple.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.mail,
                                  size: 16,
                                  color: isSchool ? Colors.blue : Colors.purple,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isSchool ? l10n.schoolMessage : l10n.teacherMessage,
                                  style: AppTheme.tajawal(
                                    fontSize: 12,
                                    color: isSchool ? Colors.blue.shade700 : Colors.purple.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Message Content
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
                            message!['subject'] as String,
                            style: AppTheme.tajawal(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.gray800,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            message!['fullMessage'] as String,
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              color: AppTheme.gray600,
                              height: 1.8,
                            ),
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
    );
  }
}

