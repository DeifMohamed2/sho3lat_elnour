import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.backgroundLight,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'الشروط والأحكام',
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
                      'الشروط والأحكام',
                      style: AppTheme.tajawal(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.gray800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'آخر تحديث: ديسمبر 2025',
                      style: AppTheme.tajawal(
                        fontSize: 12,
                        color: AppTheme.gray500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSection(
                      title: '1. القبول بالشروط',
                      content:
                          'باستخدامك تطبيق "مدارس شعلة النور"، فإنك تقبل وتوافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط، فيرجى عدم استخدام التطبيق.',
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: '2. استخدام التطبيق',
                      content:
                          'يُسمح لك باستخدام تطبيق "مدارس شعلة النور" للأغراض التعليمية فقط. يجب عليك استخدام التطبيق بطريقة قانونية ووفقاً لهذه الشروط. يُمنع استخدام التطبيق لأي غرض غير قانوني أو غير مصرح به.',
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: '3. الحساب والمعلومات',
                      content:
                          'أنت مسؤول عن الحفاظ على سرية معلومات حسابك وكلمة المرور. يجب عليك إبلاغنا فوراً عن أي استخدام غير مصرح به لحسابك. نلتزم بحماية خصوصية معلوماتك وفقاً لسياسة الخصوصية الخاصة بنا.',
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: '4. المحتوى والبيانات',
                      content:
                          'جميع المحتويات والبيانات المعروضة في التطبيق مملوكة للمدرسة أو لطرف ثالث مرخص. لا يجوز نسخ أو توزيع أو تعديل أي محتوى دون إذن كتابي.',
                    ),
                    const SizedBox(height: 20),
                    _buildSection(
                      title: '5. التعديلات',
                      content:
                          'نحتفظ بالحق في تعديل أو تحديث هذه الشروط والأحكام في أي وقت. سيتم إشعارك بأي تغييرات جوهرية من خلال التطبيق. استمرار استخدامك للتطبيق بعد التعديلات يعني موافقتك على الشروط المحدثة.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
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

