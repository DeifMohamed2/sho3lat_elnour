import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/localization/app_localizations.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            l10n.aboutApp,
            style: AppTheme.tajawal(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
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
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Logo and Name
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
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/logo-madrasty.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.appTitle,
                      style: AppTheme.tajawal(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gray800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.parentApp,
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        color: AppTheme.gray500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // App Information
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
                      l10n.appInfo,
                      style: AppTheme.tajawal(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gray800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildInfoRow(
                      icon: Icons.info_outline,
                      label: l10n.version,
                      value: l10n.versionNumber,
                      iconColor: AppTheme.primaryBlue,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.calendar_today,
                      label: l10n.releaseDate,
                      value: l10n.releaseDateValue,
                      iconColor: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.email,
                      label: l10n.email,
                      value: 'support@madrasty.com',
                      iconColor: Colors.purple,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Description
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
                        const Icon(Icons.description, color: AppTheme.primaryBlue, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          l10n.aboutSection,
                          style: AppTheme.tajawal(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.gray800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.aboutDescription,
                      style: AppTheme.tajawal(
                        fontSize: 14,
                        color: AppTheme.gray700,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),

    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
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
    );
  }
}

