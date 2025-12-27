# Home Page Requirements & Implementation Guide

## Overview
This document outlines what needs to be implemented to make the Home Tab (`home_tab.dart`) fully functional with real data integration.

## Current State Analysis

### ✅ What's Working
- UI layout and design is complete
- Quick Actions navigation works (switches between tabs)
- Tab header with student selector
- Navigation to notifications screen from header
- Basic UI components are styled correctly

### ❌ What's Missing/Needs Implementation

#### 1. **Today's Attendance Status Section** (Lines 40-118)
**Current State:**
- Hardcoded data showing "حاضر" (Present) with fixed time "7:15 صباحاً"
- Static green check icon
- No dynamic data based on actual attendance

**What's Needed:**
- **Data Model**: Create `AttendanceStatus` model
  ```dart
  class AttendanceStatus {
    final String status; // 'present', 'absent', 'late', 'not_recorded'
    final DateTime? entryTime;
    final DateTime? exitTime;
    final String? notes;
    final DateTime date;
  }
  ```

- **Service/Repository**: Create `AttendanceService` to fetch today's attendance
  ```dart
  class AttendanceService {
    Future<AttendanceStatus?> getTodayAttendance(String studentId);
    Future<List<AttendanceStatus>> getAttendanceHistory(String studentId, DateTime startDate, DateTime endDate);
  }
  ```

- **State Management**: Convert `HomeTab` to `StatefulWidget` to:
  - Fetch attendance data on init
  - Show loading state while fetching
  - Handle error states
  - Display appropriate UI based on status (present/absent/late/not recorded)

- **UI Updates Needed**:
  - Dynamic status text and color based on actual data
  - Show "لم يتم التسجيل" (Not Recorded) if no attendance data
  - Show actual entry time from API
  - Handle different statuses with appropriate colors:
    - Present: Green
    - Absent: Red
    - Late: Orange
    - Not Recorded: Gray

#### 2. **Notifications Section** (Lines 195-261)
**Current State:**
- 3 hardcoded notifications
- "عرض الكل" (View All) button does nothing (`onPressed: () {}`)
- No data fetching
- No loading/error states

**What's Needed:**
- **Data Model**: Create `Notification` model
  ```dart
  class Notification {
    final String id;
    final String title;
    final String description;
    final DateTime timestamp;
    final NotificationType type; // attendance, message, grade, announcement, etc.
    final bool isRead;
    final IconData icon;
    final Color iconColor;
  }
  ```

- **Service/Repository**: Create `NotificationService` to fetch notifications
  ```dart
  class NotificationService {
    Future<List<Notification>> getRecentNotifications(String studentId, {int limit = 3});
    Future<List<Notification>> getAllNotifications(String studentId);
    Future<void> markAsRead(String notificationId);
    Future<void> markAllAsRead(String studentId);
  }
  ```

- **State Management**: 
  - Fetch recent notifications (limit 3) on init
  - Show loading indicator while fetching
  - Handle empty state (no notifications)
  - Handle error states

- **Fix "عرض الكل" Button** (Line 224):
  ```dart
  onPressed: () => Navigator.of(context).pushNamed('/notifications'),
  ```

- **UI Updates Needed**:
  - Display notifications dynamically from API
  - Show "لا توجد إشعارات" (No notifications) when empty
  - Format time relative to current time ("منذ ساعة", "منذ 5 دقائق", etc.)
  - Make notifications clickable to navigate to details

#### 3. **Data Fetching & State Management**

**Current State:**
- `HomeTab` is a `StatelessWidget` with no data fetching
- All data is hardcoded

**What's Needed:**
- Convert to `StatefulWidget` or use a state management solution (Provider, Riverpod, Bloc, etc.)
- Implement loading states
- Implement error handling
- Implement refresh functionality (pull-to-refresh)

**Recommended Approach:**
```dart
class HomeTab extends StatefulWidget {
  // ... existing parameters
}

class _HomeTabState extends State<HomeTab> {
  AttendanceStatus? _todayAttendance;
  List<Notification> _recentNotifications = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final attendance = await AttendanceService().getTodayAttendance(widget.student?['id']);
      final notifications = await NotificationService().getRecentNotifications(widget.student?['id'], limit: 3);
      
      setState(() {
        _todayAttendance = attendance;
        _recentNotifications = notifications;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('حدث خطأ: $_error'),
            ElevatedButton(
              onPressed: _loadData,
              child: Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    // ... existing UI with dynamic data
  }
}
```

#### 4. **API Integration**

**What's Needed:**
- Define API endpoints:
  - `GET /api/students/{studentId}/attendance/today` - Get today's attendance
  - `GET /api/students/{studentId}/notifications/recent?limit=3` - Get recent notifications
  - `GET /api/students/{studentId}/notifications` - Get all notifications
  - `POST /api/notifications/{notificationId}/read` - Mark notification as read

- Create HTTP client service (using `http` or `dio` package)
- Handle authentication tokens
- Handle network errors
- Implement retry logic for failed requests

**Example Service Structure:**
```dart
class ApiService {
  final String baseUrl;
  final String? authToken;

  Future<Map<String, dynamic>> get(String endpoint) async {
    // HTTP GET implementation
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    // HTTP POST implementation
  }
}
```

#### 5. **Error Handling & Edge Cases**

**What's Needed:**
- Network connectivity check
- Handle API errors (400, 401, 404, 500, etc.)
- Handle timeout errors
- Show user-friendly error messages in Arabic
- Retry mechanism for failed requests
- Offline state handling (if applicable)

#### 6. **Performance Optimizations**

**What's Needed:**
- Cache attendance data (today's attendance doesn't change frequently)
- Cache notifications (with timestamp to refresh when needed)
- Implement pagination for notifications if list grows
- Lazy loading for images/icons if needed

#### 7. **Pull-to-Refresh**

**What's Needed:**
- Wrap `SingleChildScrollView` with `RefreshIndicator`
- Implement refresh callback to reload data
- Show refresh indicator during pull

```dart
RefreshIndicator(
  onRefresh: _loadData,
  child: SingleChildScrollView(
    // ... existing content
  ),
)
```

## Implementation Priority

### Phase 1: Critical (Must Have)
1. ✅ Fix "عرض الكل" button navigation
2. ✅ Convert HomeTab to StatefulWidget
3. ✅ Create data models (AttendanceStatus, Notification)
4. ✅ Create service classes (AttendanceService, NotificationService)
5. ✅ Implement basic data fetching
6. ✅ Add loading states
7. ✅ Add error handling

### Phase 2: Important (Should Have)
1. ✅ Implement pull-to-refresh
2. ✅ Add empty states
3. ✅ Format relative time for notifications
4. ✅ Make notifications clickable
5. ✅ Handle different attendance statuses

### Phase 3: Nice to Have (Could Have)
1. ✅ Implement caching
2. ✅ Add offline support
3. ✅ Real-time updates (WebSocket/SSE)
4. ✅ Notification badges/counts
5. ✅ Analytics/tracking

## File Structure Recommendations

```
lib/
├── core/
│   ├── models/
│   │   ├── attendance_status.dart
│   │   └── notification.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   ├── attendance_service.dart
│   │   └── notification_service.dart
│   └── utils/
│       └── date_formatter.dart
├── features/
│   └── home/
│       └── tabs/
│           └── home_tab.dart (update existing)
```

## Testing Requirements

1. **Unit Tests:**
   - Test data models
   - Test service methods
   - Test date formatting utilities

2. **Widget Tests:**
   - Test loading state
   - Test error state
   - Test empty state
   - Test with real data

3. **Integration Tests:**
   - Test full data flow from API to UI
   - Test error scenarios
   - Test refresh functionality

## Notes

- All text should be in Arabic (RTL)
- Follow existing design patterns and theme
- Maintain consistency with other tabs
- Ensure proper error messages are user-friendly
- Consider accessibility (screen readers, etc.)

## Dependencies to Add

If not already present, you may need:
- `http` or `dio` for API calls
- `provider` or `riverpod` or `bloc` for state management (optional)
- `intl` for date formatting
- `connectivity_plus` for network status (optional)

