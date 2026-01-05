import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/localization/app_localizations.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
            l10n.termsAndConditions,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      l10n.termsAndConditions,
                      style: AppTheme.tajawal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gray800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.lastUpdate,
                      style: AppTheme.tajawal(
                        fontSize: 12,
                        color: AppTheme.gray500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: l10n.termsSection1Title,
                      content: l10n.termsSection1Content,
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: l10n.termsSection2Title,
                      content: l10n.termsSection2Content,
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: l10n.termsSection3Title,
                      content: l10n.termsSection3Content,
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: l10n.termsSection4Title,
                      content: l10n.termsSection4Content,
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: l10n.termsSection5Title,
                      content: l10n.termsSection5Content,
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

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.tajawal(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: AppTheme.tajawal(
            fontSize: 14,
            color: AppTheme.gray700,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

