import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MessagesTab extends StatefulWidget {
  final Map<String, dynamic>? student;
  final VoidCallback? onShowStudentSelector;
  final String title;
  final VoidCallback? onProfileTap;
  final Future<void> Function()? onRefresh;

  const MessagesTab({
    super.key,
    this.student,
    this.onShowStudentSelector,
    required this.title,
    this.onProfileTap,
    this.onRefresh,
  });

  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  String _filter = 'all';

  final List<Map<String, dynamic>> _messages = [
    {
      'id': 1,
      'from': 'إدارة المدرسة',
      'subject': 'إعلان عن الاجتماع الشهري لأولياء الأمور',
      'preview': 'ندعوكم لحضور الاجتماع الشهري يوم الأحد القادم الساعة 4 مساءً في قاعة المدرسة الرئيسية...',
      'date': 'منذ ساعتين',
      'icon': '🏫',
      'type': 'school',
      'unread': true,
      'fullMessage': 'ندعوكم لحضور الاجتماع الشهري يوم الأحد القادم الساعة 4 مساءً في قاعة المدرسة الرئيسية. سيتم مناقشة خطة الفصل الدراسي الثاني والأنشطة المدرسية القادمة. نأمل حضوركم.',
    },
    {
      'id': 2,
      'from': 'أ. خالد سالم',
      'subject': 'تحسن ملحوظ في مادة الرياضيات',
      'preview': 'أود أن أشيد بالتحسن الملحوظ الذي أظهره الطالب في مادة الرياضيات خلال الأسبوعين الماضيين...',
      'date': 'منذ 5 ساعات',
      'icon': '👨‍🏫',
      'type': 'teacher',
      'unread': true,
      'fullMessage': 'أود أن أشيد بالتحسن الملحوظ الذي أظهره الطالب محمد في مادة الرياضيات خلال الأسبوعين الماضيين. لقد كان حريصاً على أداء الواجبات والمشاركة الفعالة في الحصص. استمر في التشجيع والمتابعة.',
    },
    {
      'id': 3,
      'from': 'إدارة المدرسة',
      'subject': 'جدول الاختبارات النهائية',
      'preview': 'يسرنا إعلامكم بأن جدول الاختبارات النهائية للفصل الدراسي الأول أصبح متاحاً الآن...',
      'date': 'أمس',
      'icon': '🏫',
      'type': 'school',
      'unread': false,
      'fullMessage': 'يسرنا إعلامكم بأن جدول الاختبارات النهائية للفصل الدراسي الأول أصبح متاحاً الآن. تبدأ الاختبارات يوم 25 ديسمبر وتستمر لمدة أسبوعين. يمكنكم الاطلاع على الجدول من خلال قسم الجدول الدراسي.',
    },
    {
      'id': 4,
      'from': 'أ. سارة أحمد',
      'subject': 'مشروع العلوم القادم',
      'preview': 'نرجو مساعدة الطالب في إعداد مشروع العلوم عن الطاقة المتجددة المقرر تسليمه يوم الخميس...',
      'date': 'منذ يومين',
      'icon': '👩‍🏫',
      'type': 'teacher',
      'unread': false,
      'fullMessage': 'نرجو مساعدة الطالب في إعداد مشروع العلوم عن الطاقة المتجددة المقرر تسليمه يوم الخميس القادم. المشروع يتطلب بحث بسيط ونموذج توضيحي. يمكن استخدام مواد بسيطة من المنزل. شكراً لتعاونكم.',
    },
    {
      'id': 5,
      'from': 'أ. فاطمة علي',
      'subject': 'تكريم الطلاب المتفوقين',
      'preview': 'يسعدني إبلاغكم بأن ابنكم محمد من ضمن الطلاب المتفوقين هذا الشهر...',
      'date': 'منذ 3 أيام',
      'icon': '👩‍🏫',
      'type': 'teacher',
      'unread': false,
      'fullMessage': 'يسعدني إبلاغكم بأن ابنكم محمد من ضمن الطلاب المتفوقين هذا الشهر في مادة اللغة العربية. سيتم تكريمه في طابور الصباح يوم الأحد القادم. نهنئكم ونتمنى له دوام التفوق والنجاح.',
    },
    {
      'id': 6,
      'from': 'إدارة المدرسة',
      'subject': 'تحديث نظام الحضور والانصراف',
      'preview': 'نود إعلامكم بتحديث نظام الحضور والانصراف الإلكتروني. الآن يمكنكم متابعة وقت دخول وخروج أبنائكم...',
      'date': 'منذ أسبوع',
      'icon': '🏫',
      'type': 'school',
      'unread': false,
      'fullMessage': 'نود إعلامكم بتحديث نظام الحضور والانصراف الإلكتروني. الآن يمكنكم متابعة وقت دخول وخروج أبنائكم بشكل فوري عبر التطبيق. سيتم إرسال إشعار فوري عند تسجيل الحضور أو الانصراف.',
    },
  ];

  List<Map<String, dynamic>> get _filteredMessages {
    if (_filter == 'all') return _messages;
    return _messages.where((m) => m['type'] == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RefreshIndicator(
        onRefresh: widget.onRefresh ?? () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Blue Header Section with Title and Filters
            Container(
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
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title and Badge Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'الرسائل',
                        style: AppTheme.tajawal(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.white,
                        ),
                      ),
                      if (_messages.where((m) => m['unread'] == true).isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_messages.where((m) => m['unread'] == true).length} جديدة',
                            style: AppTheme.tajawal(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Filter Tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterButton('all', 'الكل (${_messages.length})'),
                        const SizedBox(width: 8),
                        _buildFilterButton('school', 'رسائل الإدارة (${_messages.where((m) => m['type'] == 'school').length})'),
                        const SizedBox(width: 8),
                        _buildFilterButton('teacher', 'رسائل المعلمين (${_messages.where((m) => m['type'] == 'teacher').length})'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Messages List
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ..._filteredMessages.map((message) => _buildMessageCard(message)),
                ],
              ),
            ),
            const SizedBox(height: 20), // Bottom padding
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String filter, String label) {
    final isSelected = _filter == filter;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _filter = filter),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: AppTheme.tajawal(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? AppTheme.primaryBlue : AppTheme.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageCard(Map<String, dynamic> message) {
    final isUnread = message['unread'] == true;
    final isSchool = message['type'] == 'school';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed('/messageDetails', arguments: {'message': message}),
          borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(16),
                border: isUnread
                    ? Border.all(
                        color: AppTheme.primaryBlue.withOpacity(0.3),
                        width: 1.5,
                      )
                    : null,
              ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  // Content on the right
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                                      
                            // Sender Icon
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: isSchool ? AppTheme.primaryBlue.withOpacity(0.15) : Colors.purple.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  message['icon'] as String,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      message['from'] as String,
                                      style: AppTheme.tajawal(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.gray800,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (isUnread) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppTheme.primaryBlue,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Text(
                              message['date'] as String,
                              style: AppTheme.tajawal(
                                fontSize: 12,
                                color: AppTheme.gray500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          message['subject'] as String,
                          style: AppTheme.tajawal(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.gray700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message['preview'] as String,
                          style: AppTheme.tajawal(
                            fontSize: 12,
                            color: AppTheme.gray600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Arrow icon on the left (points right in RTL)
                  const Icon(Icons.chevron_right, color: AppTheme.gray400, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
