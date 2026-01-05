import 'package:flutter/material.dart';

/// App Localizations class that provides localized strings based on the current locale.
/// Usage: AppLocalizations.of(context).appTitle
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('ar'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      // ==================== GENERAL ====================
      'appTitle': 'مدارس شعلة النور',
      'parentApp': 'تطبيق أولياء الأمور',
      'cancel': 'إلغاء',
      'ok': 'موافق',
      'retry': 'إعادة المحاولة',
      'loading': 'جاري التحميل...',
      'error': 'حدث خطأ',
      'success': 'تمت العملية بنجاح',
      'viewAll': 'عرض الكل',
      'noData': 'لا توجد بيانات',
      'notAvailable': 'غير متاح',
      'version': 'الإصدار',
      'versionNumber': '1.0.0',

      // ==================== AUTH / LOGIN ====================
      'welcome': 'أهلاً بك',
      'loginSubtitle': 'قم بتسجيل الدخول لمتابعة أداء أبنائك الدراسي',
      'phoneNumber': 'رقم الجوال',
      'studentCode': 'كود الطالب',
      'enterStudentCode': 'أدخل كود الطالب',
      'pleaseEnterPhone': 'الرجاء إدخال رقم الجوال',
      'pleaseEnterStudentCode': 'الرجاء إدخال كود الطالب',
      'login': 'تسجيل الدخول',
      'registerHint': 'للحصول على حساب جديد تواصل مع إدارة المدرسة',
      'studentNotFound': 'لم يتم العثور على بيانات الطالب',
      'unexpectedError': 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى',
      'parent': 'ولي أمر',

      // ==================== OTP ====================
      'verifyCode': 'التحقق من الرمز',
      'otpSentTo': 'تم إرسال رمز التحقق إلى رقم الجوال',
      'resendCodeAfter': 'إعادة إرسال الرمز بعد',
      'seconds': 'ثانية',
      'resendCode': 'إعادة إرسال الرمز',
      'verify': 'تحقق',

      // ==================== SELECT STUDENT ====================
      'selectStudent': 'اختر الطالب',
      'selectStudentSubtitle': 'اختر من قائمة أبنائك لمتابعة أدائهم الدراسي',
      'switchStudentHint': 'يمكنك التبديل بين الطلاب في أي وقت من الملف الشخصي',
      'noStudents': 'لا يوجد طلاب',
      'blocked': 'محظور',

      // ==================== NAVIGATION / TABS ====================
      'home': 'الرئيسية',
      'attendance': 'الحضور',
      'timetable': 'الجدول',
      'certificates': 'الشهادات',
      'financial': 'المالية',

      // ==================== HOME TAB ====================
      'todayAttendanceStatus': 'حالة الحضور اليوم',
      'entryTime': 'وقت الدخول:',
      'noAttendanceRecorded': 'لم يتم تسجيل الحضور بعد',
      'quickActions': 'الإجراءات السريعة',
      'settings': 'الإعدادات',
      'recentNotifications': 'الإشعارات الأخيرة',
      'noNewNotifications': 'لا توجد إشعارات جديدة',

      // ==================== ATTENDANCE ====================
      'filter': 'تصفية',
      'allStatuses': 'جميع الحالات',
      'present': 'حضور',
      'absent': 'غياب',
      'late': 'تأخير',
      'selectDate': 'اختر التاريخ',
      'clearFilter': 'مسح التصفية',
      'noAttendanceData': 'لا توجد بيانات حضور',
      'attendanceDetails': 'تفاصيل الحضور',
      'presentStatus': 'حاضر',
      'absentStatus': 'غائب',
      'lateStatus': 'متأخر',
      'earlyLeave': 'انصراف مبكر',
      'permission': 'إذن',
      'timeDetails': 'تفاصيل الوقت',
      'entryTimeLabel': 'وقت الدخول',
      'schoolEntry': 'دخول إلى المدرسة',
      'exitTime': 'وقت الانصراف',
      'schoolExit': 'خروج من المدرسة',
      'totalDuration': 'المدة الإجمالية',
      'timeAtSchool': 'وقت البقاء في المدرسة',
      'hoursAndMinutes': '@hours ساعة و @minutes دقيقة',
      'hoursOnly': '@hours ساعة',
      'minutesOnly': '@minutes دقيقة',
      'notes': 'ملاحظات',
      'noNotes': 'لا توجد ملاحظات',
      'departure': 'انصراف',

      // ==================== MONTHS ====================
      'january': 'يناير',
      'february': 'فبراير',
      'march': 'مارس',
      'april': 'أبريل',
      'may': 'مايو',
      'june': 'يونيو',
      'july': 'يوليو',
      'august': 'أغسطس',
      'september': 'سبتمبر',
      'october': 'أكتوبر',
      'november': 'نوفمبر',
      'december': 'ديسمبر',

      // ==================== DAYS ====================
      'sunday': 'الأحد',
      'monday': 'الإثنين',
      'tuesday': 'الثلاثاء',
      'wednesday': 'الأربعاء',
      'thursday': 'الخميس',
      'friday': 'الجمعة',
      'saturday': 'السبت',

      // ==================== TIME ====================
      'am': 'ص',
      'pm': 'م',
      'morning': 'صباحاً',
      'evening': 'مساءً',

      // ==================== TIMETABLE ====================
      'timetableDownloaded': 'تم تحميل الجدول بنجاح',
      'downloadTimetable': 'تحميل الجدول',
      'downloadingTimetable': 'جاري تحميل الجدول...',
      'noTimetableAvailable': 'لا يوجد جدول متاح حالياً',
      'timetableComingSoon': 'سيتم إضافة الجدول قريباً',

      // ==================== GRADES / CERTIFICATES ====================
      'certificateLocked': 'هذه الشهادة مقفلة حالياً',
      'fileNotAvailable': 'الملف غير متاح حالياً',
      'openingCertificate': 'جاري فتح الشهادة...',
      'errorOpeningCertificate': 'حدث خطأ أثناء فتح الشهادة',
      'noCertificatesAvailable': 'لا توجد شهادات متاحة',
      'certificatesComingSoon': 'سيتم إضافة الشهادات عند توفرها',
      'locked': 'مقفلة',
      'lockedCertificateMessage':
          'هذه الشهادة مقفلة حالياً. يرجى التواصل مع إدارة المدرسة لفتحها.',
      'downloadCertificate': 'تحميل الشهادة',

      // ==================== FINANCIAL ====================
      'totalFees': 'اجمالي المصروفات',
      'paidAmount': 'المدفوع',
      'remainingBalance': 'المتبقي',
      'paymentCount': 'عدد المدفوعات',
      'currency': 'ج.م',
      'paymentHistory': 'سجل المدفوعات',
      'noPayments': 'لا توجد مدفوعات',
      'paymentNumber': 'دفعة رقم @number',
      'paymentMethod': 'طريقة الدفع',

      // ==================== NOTIFICATIONS ====================
      'notifications': 'الإشعارات',
      'newNotificationsCount': '@count إشعار جديد',
      'markAllAsRead': 'تعليم الكل كمقروء',
      'noNotifications': 'لا توجد إشعارات',
      'notificationDetails': 'تفاصيل الإشعار',
      'announcement': 'إعلان',
      'message': 'رسالة',
      'notification': 'إشعار',
      'details': 'التفاصيل',
      'timing': 'التوقيت',
      'sentDate': 'تاريخ الإرسال',
      'readDate': 'تاريخ القراءة',
      'status': 'الحالة',
      'read': 'تم القراءة',
      'unread': 'غير مقروء',

      // ==================== SETTINGS ====================
      'logout': 'تسجيل الخروج',
      'logoutConfirmation': 'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
      'languageChangedToArabic': 'تم تغيير اللغة إلى العربية',
      'languageChangeFailed': 'فشل في تغيير اللغة',
      'account': 'الحساب',
      'parentProfile': 'ملف ولي الأمر',
      'changeStudent': 'تغيير الطالب',
      'attendanceNotifications': 'إشعارات الحضور',
      'attendanceNotificationsSubtitle': 'تنبيهات عند تسجيل الحضور',
      'messageNotifications': 'إشعارات الرسائل',
      'messageNotificationsSubtitle': 'تنبيهات الرسائل الجديدة',
      'gradeNotifications': 'إشعارات الدرجات',
      'gradeNotificationsSubtitle': 'تنبيهات عند إضافة درجات جديدة',
      'general': 'عام',
      'language': 'اللغة',
      'arabic': 'العربية',
      'english': 'English',
      'termsAndConditions': 'الشروط والأحكام',
      'aboutApp': 'حول التطبيق',
      'selectLanguage': 'اختر اللغة',
      'englishArabic': 'الإنجليزية',
      'deleteAccount': 'حذف الحساب',
      'deleteAccountConfirmation': 'هل أنت متأكد من رغبتك في حذف حسابك؟',
      'deleteAccountWarning':
          'سيتم حذف جميع بياناتك وبيانات أبنائك بشكل نهائي ولا يمكن استرجاعها. هذه العملية لا يمكن التراجع عنها.',
      'deleteAccountHint': 'يرجى التأكد من رغبتك في المتابعة',
      'accountDeletedSuccess': 'تم حذف الحساب بنجاح',

      // ==================== TERMS AND CONDITIONS ====================
      'lastUpdate': 'آخر تحديث: ديسمبر 2025',
      'termsSection1Title': '1. القبول بالشروط',
      'termsSection1Content':
          'باستخدامك تطبيق "مدارس شعلة النور"، فإنك تقبل وتوافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق على أي من هذه الشروط، يرجى عدم استخدام التطبيق.',
      'termsSection2Title': '2. استخدام التطبيق',
      'termsSection2Content':
          'يُسمح لك باستخدام تطبيق "مدارس شعلة النور" للأغراض التعليمية فقط. يجب عدم استخدام التطبيق لأي أغراض غير قانونية أو غير مصرح بها.',
      'termsSection3Title': '3. الحساب والمعلومات',
      'termsSection3Content':
          'أنت مسؤول عن الحفاظ على سرية معلومات حسابك وكلمة المرور الخاصة بك. يجب عليك إخطارنا فوراً بأي استخدام غير مصرح به لحسابك.',
      'termsSection4Title': '4. المحتوى والبيانات',
      'termsSection4Content':
          'جميع البيانات والمعلومات المعروضة في التطبيق هي ملك لمدارس شعلة النور. يُحظر نسخ أو توزيع أو تعديل أي محتوى من التطبيق دون إذن كتابي.',
      'termsSection5Title': '5. التعديلات',
      'termsSection5Content':
          'نحتفظ بالحق في تعديل هذه الشروط والأحكام في أي وقت. سيتم إخطارك بأي تغييرات جوهرية عبر التطبيق أو البريد الإلكتروني.',

      // ==================== ABOUT APP ====================
      'appInfo': 'معلومات التطبيق',
      'releaseDate': 'تاريخ الإصدار',
      'releaseDateValue': 'ديسمبر 2025',
      'email': 'البريد الإلكتروني',
      'aboutSection': 'عن التطبيق',
      'aboutDescription':
          'تطبيق "مدارس شعلة النور" هو تطبيق متكامل لأولياء الأمور لمتابعة أداء أبنائهم الدراسي. يوفر التطبيق إمكانية متابعة الحضور والغياب، عرض الجدول الدراسي، الاطلاع على الدرجات والشهادات، ومتابعة المستحقات المالية.',

      // ==================== PARENT PROFILE ====================
      'myProfile': 'ملفي',
      'phone': 'رقم الهاتف',
      'children': 'الأبناء',
      'noChildrenRegistered': 'لا يوجد أبناء مسجلين',

      // ==================== MESSAGES ====================
      'messageNotFound': 'لم يتم العثور على الرسالة',
      'messageDetails': 'تفاصيل الرسالة',
      'schoolMessage': 'رسالة من المدرسة',
      'teacherMessage': 'رسالة من المعلم',
      'messages': 'الرسائل',
      'newMessages': 'جديدة',
      'allFilter': 'الكل',
      'schoolMessages': 'رسائل الإدارة',
      'teacherMessages': 'رسائل المعلمين',

      // ==================== GRADES ====================
      'grade': 'الصف',
      'class_': 'الفصل',
    },

    'en': {
      // ==================== GENERAL ====================
      'appTitle': 'Sho3lat El-Nour Schools',
      'parentApp': 'Parents App',
      'cancel': 'Cancel',
      'ok': 'OK',
      'retry': 'Retry',
      'loading': 'Loading...',
      'error': 'An error occurred',
      'success': 'Operation successful',
      'viewAll': 'View All',
      'noData': 'No data available',
      'notAvailable': 'Not available',
      'version': 'Version',
      'versionNumber': '1.0.0',

      // ==================== AUTH / LOGIN ====================
      'welcome': 'Welcome',
      'loginSubtitle': 'Login to track your children\'s academic performance',
      'phoneNumber': 'Phone Number',
      'studentCode': 'Student Code',
      'enterStudentCode': 'Enter student code',
      'pleaseEnterPhone': 'Please enter phone number',
      'pleaseEnterStudentCode': 'Please enter student code',
      'login': 'Login',
      'registerHint': 'Contact school administration for a new account',
      'studentNotFound': 'Student data not found',
      'unexpectedError': 'An unexpected error occurred. Please try again',
      'parent': 'Parent',

      // ==================== OTP ====================
      'verifyCode': 'Verify Code',
      'otpSentTo': 'Verification code sent to your phone number',
      'resendCodeAfter': 'Resend code after',
      'seconds': 'seconds',
      'resendCode': 'Resend Code',
      'verify': 'Verify',

      // ==================== SELECT STUDENT ====================
      'selectStudent': 'Select Student',
      'selectStudentSubtitle':
          'Choose from your children to track their performance',
      'switchStudentHint':
          'You can switch between students anytime from the profile',
      'noStudents': 'No students',
      'blocked': 'Blocked',

      // ==================== NAVIGATION / TABS ====================
      'home': 'Home',
      'attendance': 'Attendance',
      'timetable': 'Timetable',
      'certificates': 'Certificates',
      'financial': 'Financial',

      // ==================== HOME TAB ====================
      'todayAttendanceStatus': 'Today\'s Attendance Status',
      'entryTime': 'Entry Time:',
      'noAttendanceRecorded': 'No attendance recorded yet',
      'quickActions': 'Quick Actions',
      'settings': 'Settings',
      'recentNotifications': 'Recent Notifications',
      'noNewNotifications': 'No new notifications',

      // ==================== ATTENDANCE ====================
      'filter': 'Filter',
      'allStatuses': 'All Statuses',
      'present': 'Present',
      'absent': 'Absent',
      'late': 'Late',
      'selectDate': 'Select Date',
      'clearFilter': 'Clear Filter',
      'noAttendanceData': 'No attendance data',
      'attendanceDetails': 'Attendance Details',
      'presentStatus': 'Present',
      'absentStatus': 'Absent',
      'lateStatus': 'Late',
      'earlyLeave': 'Early Leave',
      'permission': 'Permission',
      'timeDetails': 'Time Details',
      'entryTimeLabel': 'Entry Time',
      'schoolEntry': 'School Entry',
      'exitTime': 'Exit Time',
      'schoolExit': 'School Exit',
      'totalDuration': 'Total Duration',
      'timeAtSchool': 'Time at school',
      'hoursAndMinutes': '@hours hours and @minutes minutes',
      'hoursOnly': '@hours hours',
      'minutesOnly': '@minutes minutes',
      'notes': 'Notes',
      'noNotes': 'No notes',
      'departure': 'Departure',

      // ==================== MONTHS ====================
      'january': 'January',
      'february': 'February',
      'march': 'March',
      'april': 'April',
      'may': 'May',
      'june': 'June',
      'july': 'July',
      'august': 'August',
      'september': 'September',
      'october': 'October',
      'november': 'November',
      'december': 'December',

      // ==================== DAYS ====================
      'sunday': 'Sunday',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
      'friday': 'Friday',
      'saturday': 'Saturday',

      // ==================== TIME ====================
      'am': 'AM',
      'pm': 'PM',
      'morning': 'Morning',
      'evening': 'Evening',

      // ==================== TIMETABLE ====================
      'timetableDownloaded': 'Timetable downloaded successfully',
      'downloadTimetable': 'Download Timetable',
      'downloadingTimetable': 'Downloading timetable...',
      'noTimetableAvailable': 'No timetable available',
      'timetableComingSoon': 'Timetable coming soon',

      // ==================== GRADES / CERTIFICATES ====================
      'certificateLocked': 'This certificate is currently locked',
      'fileNotAvailable': 'File not available',
      'openingCertificate': 'Opening certificate...',
      'errorOpeningCertificate': 'Error opening certificate',
      'noCertificatesAvailable': 'No certificates available',
      'certificatesComingSoon': 'Certificates will be added when available',
      'locked': 'Locked',
      'lockedCertificateMessage':
          'This certificate is currently locked. Please contact school administration to unlock it.',
      'downloadCertificate': 'Download Certificate',

      // ==================== FINANCIAL ====================
      'totalFees': 'Total Fees',
      'paidAmount': 'Paid',
      'remainingBalance': 'Remaining',
      'paymentCount': 'Payment Count',
      'currency': 'EGP',
      'paymentHistory': 'Payment History',
      'noPayments': 'No payments',
      'paymentNumber': 'Payment #@number',
      'paymentMethod': 'Payment Method',

      // ==================== NOTIFICATIONS ====================
      'notifications': 'Notifications',
      'newNotificationsCount': '@count new notification(s)',
      'markAllAsRead': 'Mark all as read',
      'noNotifications': 'No notifications',
      'notificationDetails': 'Notification Details',
      'announcement': 'Announcement',
      'message': 'Message',
      'notification': 'Notification',
      'details': 'Details',
      'timing': 'Timing',
      'sentDate': 'Sent Date',
      'readDate': 'Read Date',
      'status': 'Status',
      'read': 'Read',
      'unread': 'Unread',

      // ==================== SETTINGS ====================
      'logout': 'Logout',
      'logoutConfirmation': 'Are you sure you want to logout?',
      'languageChangedToArabic': 'Language changed to Arabic',
      'languageChangeFailed': 'Failed to change language',
      'account': 'Account',
      'parentProfile': 'Parent Profile',
      'changeStudent': 'Change Student',
      'attendanceNotifications': 'Attendance Notifications',
      'attendanceNotificationsSubtitle': 'Alerts when attendance is recorded',
      'messageNotifications': 'Message Notifications',
      'messageNotificationsSubtitle': 'Alerts for new messages',
      'gradeNotifications': 'Grade Notifications',
      'gradeNotificationsSubtitle': 'Alerts when new grades are added',
      'general': 'General',
      'language': 'Language',
      'arabic': 'العربية',
      'english': 'English',
      'termsAndConditions': 'Terms and Conditions',
      'aboutApp': 'About App',
      'selectLanguage': 'Select Language',
      'englishArabic': 'English',
      'deleteAccount': 'Delete Account',
      'deleteAccountConfirmation':
          'Are you sure you want to delete your account?',
      'deleteAccountWarning':
          'All your data and your children\'s data will be permanently deleted and cannot be recovered. This action cannot be undone.',
      'deleteAccountHint': 'Please confirm you want to proceed',
      'accountDeletedSuccess': 'Account deleted successfully',

      // ==================== TERMS AND CONDITIONS ====================
      'lastUpdate': 'Last Update: December 2025',
      'termsSection1Title': '1. Acceptance of Terms',
      'termsSection1Content':
          'By using the "Sho3lat El-Nour Schools" app, you accept and agree to be bound by these terms and conditions. If you do not agree to any of these terms, please do not use the app.',
      'termsSection2Title': '2. Use of the App',
      'termsSection2Content':
          'You are permitted to use the "Sho3lat El-Nour Schools" app for educational purposes only. The app must not be used for any illegal or unauthorized purposes.',
      'termsSection3Title': '3. Account and Information',
      'termsSection3Content':
          'You are responsible for maintaining the confidentiality of your account information and password. You must notify us immediately of any unauthorized use of your account.',
      'termsSection4Title': '4. Content and Data',
      'termsSection4Content':
          'All data and information displayed in the app are the property of Sho3lat El-Nour Schools. Copying, distributing, or modifying any content from the app without written permission is prohibited.',
      'termsSection5Title': '5. Modifications',
      'termsSection5Content':
          'We reserve the right to modify these terms and conditions at any time. You will be notified of any material changes via the app or email.',

      // ==================== ABOUT APP ====================
      'appInfo': 'App Information',
      'releaseDate': 'Release Date',
      'releaseDateValue': 'December 2025',
      'email': 'Email',
      'aboutSection': 'About',
      'aboutDescription':
          'The "Sho3lat El-Nour Schools" app is a comprehensive app for parents to track their children\'s academic performance. The app provides attendance tracking, timetable viewing, grades and certificates access, and financial dues tracking.',

      // ==================== PARENT PROFILE ====================
      'myProfile': 'My Profile',
      'phone': 'Phone Number',
      'children': 'Children',
      'noChildrenRegistered': 'No children registered',

      // ==================== MESSAGES ====================
      'messageNotFound': 'Message not found',
      'messageDetails': 'Message Details',
      'schoolMessage': 'Message from School',
      'teacherMessage': 'Message from Teacher',
      'messages': 'Messages',
      'newMessages': 'new',
      'allFilter': 'All',
      'schoolMessages': 'School Messages',
      'teacherMessages': 'Teacher Messages',

      // ==================== GRADES ====================
      'grade': 'Grade',
      'class_': 'Class',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['ar']?[key] ??
        key;
  }

  String getWithParams(String key, Map<String, String> params) {
    String value = get(key);
    params.forEach((paramKey, paramValue) {
      value = value.replaceAll('@$paramKey', paramValue);
    });
    return value;
  }

  // Helper to check if current language is Arabic
  bool get isArabic => locale.languageCode == 'ar';

  // ==================== GENERAL ====================
  String get appTitle => get('appTitle');
  String get parentApp => get('parentApp');
  String get cancel => get('cancel');
  String get ok => get('ok');
  String get retry => get('retry');
  String get loading => get('loading');
  String get error => get('error');
  String get success => get('success');
  String get viewAll => get('viewAll');
  String get noData => get('noData');
  String get notAvailable => get('notAvailable');
  String get version => get('version');
  String get versionNumber => get('versionNumber');

  // ==================== AUTH / LOGIN ====================
  String get welcome => get('welcome');
  String get loginSubtitle => get('loginSubtitle');
  String get phoneNumber => get('phoneNumber');
  String get studentCode => get('studentCode');
  String get enterStudentCode => get('enterStudentCode');
  String get pleaseEnterPhone => get('pleaseEnterPhone');
  String get pleaseEnterStudentCode => get('pleaseEnterStudentCode');
  String get login => get('login');
  String get registerHint => get('registerHint');
  String get studentNotFound => get('studentNotFound');
  String get unexpectedError => get('unexpectedError');
  String get parent => get('parent');

  // ==================== OTP ====================
  String get verifyCode => get('verifyCode');
  String get otpSentTo => get('otpSentTo');
  String get resendCodeAfter => get('resendCodeAfter');
  String get seconds => get('seconds');
  String get resendCode => get('resendCode');
  String get verify => get('verify');

  // ==================== SELECT STUDENT ====================
  String get selectStudent => get('selectStudent');
  String get selectStudentSubtitle => get('selectStudentSubtitle');
  String get switchStudentHint => get('switchStudentHint');
  String get noStudents => get('noStudents');
  String get blocked => get('blocked');

  // ==================== NAVIGATION / TABS ====================
  String get home => get('home');
  String get attendance => get('attendance');
  String get timetable => get('timetable');
  String get certificates => get('certificates');
  String get financial => get('financial');

  // ==================== HOME TAB ====================
  String get todayAttendanceStatus => get('todayAttendanceStatus');
  String get entryTime => get('entryTime');
  String get noAttendanceRecorded => get('noAttendanceRecorded');
  String get quickActions => get('quickActions');
  String get settings => get('settings');
  String get recentNotifications => get('recentNotifications');
  String get noNewNotifications => get('noNewNotifications');

  // ==================== ATTENDANCE ====================
  String get filter => get('filter');
  String get allStatuses => get('allStatuses');
  String get present => get('present');
  String get absent => get('absent');
  String get late => get('late');
  String get selectDate => get('selectDate');
  String get clearFilter => get('clearFilter');
  String get noAttendanceData => get('noAttendanceData');
  String get attendanceDetails => get('attendanceDetails');
  String get presentStatus => get('presentStatus');
  String get absentStatus => get('absentStatus');
  String get lateStatus => get('lateStatus');
  String get earlyLeave => get('earlyLeave');
  String get permission => get('permission');
  String get timeDetails => get('timeDetails');
  String get entryTimeLabel => get('entryTimeLabel');
  String get schoolEntry => get('schoolEntry');
  String get exitTime => get('exitTime');
  String get schoolExit => get('schoolExit');
  String get totalDuration => get('totalDuration');
  String get timeAtSchool => get('timeAtSchool');
  String get notes => get('notes');
  String get noNotes => get('noNotes');
  String get departure => get('departure');

  String hoursAndMinutes(int hours, int minutes) {
    return getWithParams('hoursAndMinutes', {
      'hours': hours.toString(),
      'minutes': minutes.toString(),
    });
  }

  String hoursOnly(int hours) {
    return getWithParams('hoursOnly', {'hours': hours.toString()});
  }

  String minutesOnly(int minutes) {
    return getWithParams('minutesOnly', {'minutes': minutes.toString()});
  }

  // ==================== MONTHS ====================
  String get january => get('january');
  String get february => get('february');
  String get march => get('march');
  String get april => get('april');
  String get may => get('may');
  String get june => get('june');
  String get july => get('july');
  String get august => get('august');
  String get september => get('september');
  String get october => get('october');
  String get november => get('november');
  String get december => get('december');

  String getMonthName(int month) {
    const months = [
      'january',
      'february',
      'march',
      'april',
      'may',
      'june',
      'july',
      'august',
      'september',
      'october',
      'november',
      'december',
    ];
    if (month >= 1 && month <= 12) {
      return get(months[month - 1]);
    }
    return '';
  }

  // ==================== DAYS ====================
  String get sunday => get('sunday');
  String get monday => get('monday');
  String get tuesday => get('tuesday');
  String get wednesday => get('wednesday');
  String get thursday => get('thursday');
  String get friday => get('friday');
  String get saturday => get('saturday');

  String getDayName(int weekday) {
    const days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];
    if (weekday >= 1 && weekday <= 7) {
      return get(days[weekday - 1]);
    }
    return '';
  }

  // ==================== TIME ====================
  String get am => get('am');
  String get pm => get('pm');
  String get morning => get('morning');
  String get evening => get('evening');

  // ==================== TIMETABLE ====================
  String get timetableDownloaded => get('timetableDownloaded');
  String get downloadTimetable => get('downloadTimetable');
  String get downloadingTimetable => get('downloadingTimetable');
  String get noTimetableAvailable => get('noTimetableAvailable');
  String get timetableComingSoon => get('timetableComingSoon');

  // ==================== GRADES / CERTIFICATES ====================
  String get certificateLocked => get('certificateLocked');
  String get fileNotAvailable => get('fileNotAvailable');
  String get openingCertificate => get('openingCertificate');
  String get errorOpeningCertificate => get('errorOpeningCertificate');
  String get noCertificatesAvailable => get('noCertificatesAvailable');
  String get certificatesComingSoon => get('certificatesComingSoon');
  String get locked => get('locked');
  String get lockedCertificateMessage => get('lockedCertificateMessage');
  String get downloadCertificate => get('downloadCertificate');

  // ==================== FINANCIAL ====================
  String get totalFees => get('totalFees');
  String get paidAmount => get('paidAmount');
  String get remainingBalance => get('remainingBalance');
  String get paymentCount => get('paymentCount');
  String get currency => get('currency');
  String get paymentHistory => get('paymentHistory');
  String get noPayments => get('noPayments');
  String get paymentMethod => get('paymentMethod');

  String paymentNumber(int number) {
    return getWithParams('paymentNumber', {'number': number.toString()});
  }

  // ==================== NOTIFICATIONS ====================
  String get notifications => get('notifications');
  String get markAllAsRead => get('markAllAsRead');
  String get noNotifications => get('noNotifications');
  String get notificationDetails => get('notificationDetails');
  String get announcement => get('announcement');
  String get message => get('message');
  String get notification => get('notification');
  String get details => get('details');
  String get timing => get('timing');
  String get sentDate => get('sentDate');
  String get readDate => get('readDate');
  String get status => get('status');
  String get read => get('read');
  String get unread => get('unread');

  String newNotificationsCount(int count) {
    return getWithParams('newNotificationsCount', {'count': count.toString()});
  }

  // ==================== SETTINGS ====================
  String get logout => get('logout');
  String get logoutConfirmation => get('logoutConfirmation');
  String get languageChangedToArabic => get('languageChangedToArabic');
  String get languageChangeFailed => get('languageChangeFailed');
  String get account => get('account');
  String get parentProfile => get('parentProfile');
  String get changeStudent => get('changeStudent');
  String get attendanceNotifications => get('attendanceNotifications');
  String get attendanceNotificationsSubtitle =>
      get('attendanceNotificationsSubtitle');
  String get messageNotifications => get('messageNotifications');
  String get messageNotificationsSubtitle =>
      get('messageNotificationsSubtitle');
  String get gradeNotifications => get('gradeNotifications');
  String get gradeNotificationsSubtitle => get('gradeNotificationsSubtitle');
  String get general => get('general');
  String get language => get('language');
  String get arabic => get('arabic');
  String get english => get('english');
  String get termsAndConditions => get('termsAndConditions');
  String get aboutApp => get('aboutApp');
  String get selectLanguage => get('selectLanguage');
  String get englishArabic => get('englishArabic');
  String get deleteAccount => get('deleteAccount');
  String get deleteAccountConfirmation => get('deleteAccountConfirmation');
  String get deleteAccountWarning => get('deleteAccountWarning');
  String get deleteAccountHint => get('deleteAccountHint');
  String get accountDeletedSuccess => get('accountDeletedSuccess');

  // ==================== TERMS AND CONDITIONS ====================
  String get lastUpdate => get('lastUpdate');
  String get termsSection1Title => get('termsSection1Title');
  String get termsSection1Content => get('termsSection1Content');
  String get termsSection2Title => get('termsSection2Title');
  String get termsSection2Content => get('termsSection2Content');
  String get termsSection3Title => get('termsSection3Title');
  String get termsSection3Content => get('termsSection3Content');
  String get termsSection4Title => get('termsSection4Title');
  String get termsSection4Content => get('termsSection4Content');
  String get termsSection5Title => get('termsSection5Title');
  String get termsSection5Content => get('termsSection5Content');

  // ==================== ABOUT APP ====================
  String get appInfo => get('appInfo');
  String get releaseDate => get('releaseDate');
  String get releaseDateValue => get('releaseDateValue');
  String get email => get('email');
  String get aboutSection => get('aboutSection');
  String get aboutDescription => get('aboutDescription');

  // ==================== PARENT PROFILE ====================
  String get myProfile => get('myProfile');
  String get phone => get('phone');
  String get children => get('children');
  String get noChildrenRegistered => get('noChildrenRegistered');

  // ==================== MESSAGES ====================
  String get messageNotFound => get('messageNotFound');
  String get messageDetails => get('messageDetails');
  String get schoolMessage => get('schoolMessage');
  String get teacherMessage => get('teacherMessage');
  String get messages => get('messages');
  String get newMessages => get('newMessages');
  String get allFilter => get('allFilter');
  String get schoolMessages => get('schoolMessages');
  String get teacherMessages => get('teacherMessages');

  // ==================== GRADES ====================
  String get grade => get('grade');
  String get class_ => get('class_');

  // Helper to get language changed message based on language code
  String languageChangedMessage(String languageCode) {
    if (languageCode == 'ar') {
      return _localizedValues['ar']!['languageChangedToArabic']!;
    } else {
      return 'Language changed to English';
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
