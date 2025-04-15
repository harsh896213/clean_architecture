import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Future<void> initialize() async {
    if (!Firebase.apps.isNotEmpty) {
      await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _handleNotificationTap,
    );

    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: true,
    );

    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleTerminatedMessage(initialMessage);
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundTap);
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    await _setupNotificationChannels();
  }

  Future<void> _setupNotificationChannels() async {
    const androidChannel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      enableVibration: true,
      playSound: true,
      showBadge: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    if (!Firebase.apps.isNotEmpty) {
      await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    final notificationService = NotificationService();
    await notificationService.showInAppNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      payload: message.data.toString(),
      userId: message.data['userId'] as String?,
      groupKey: message.data['groupKey'] as String?,
    );
  }

  Future<void> showInAppNotification({
    required String title,
    required String body,
    String? payload,
    String? userId,
    String? groupKey,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      groupKey: groupKey ?? 'default_group',
      setAsGroupSummary: true,
      groupAlertBehavior: GroupAlertBehavior.summary,
      channelShowBadge: true,
      autoCancel: true,
      category: AndroidNotificationCategory.message,
      styleInformation: InboxStyleInformation(
        [body],
        contentTitle: title,
        summaryText: 'New Messages',
      ),
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      threadIdentifier: userId ?? 'default_user',
      interruptionLevel: InterruptionLevel.active,
      categoryIdentifier: 'message',
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final notificationId = _generateNotificationId(userId);

    await _localNotifications.show(
      notificationId,
      title,
      body,
      details,
      payload: payload,
    );
  }

  int _generateNotificationId(String? userId) {
    if (userId != null) {
      return userId.hashCode;
    }
    return DateTime.now().millisecond;
  }

  void _handleForegroundMessage(RemoteMessage message) {
    showInAppNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      payload: message.data.toString(),
      userId: message.data['userId'] as String?,
      groupKey: message.data['groupKey'] as String?,
    );
  }

  void _handleBackgroundTap(RemoteMessage message) {
    _handleNotificationData(message.data);
  }

  void _handleTerminatedMessage(RemoteMessage message) {
    _handleNotificationData(message.data);
  }

  void _handleNotificationTap(NotificationResponse response) {
    if (response.payload != null) {
      _handleNotificationData(jsonDecode(response.payload!));
    }
  }

  void _handleNotificationData(Map<String, dynamic> data) {
    switch (data['type']) {
      case 'activity':
      // Navigate to activity screen
        break;
      case 'medication':
      // Navigate to medication screen
        break;
      case 'appointment':
      // Navigate to appointment screen
        break;
      default:
        break;
    }
  }

  Future<String?> getDeviceToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> deleteToken() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
  }
}