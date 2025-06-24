import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz; 

class NotificationService {
  
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //(drawable, mipmap);
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true, 
      requestBadgePermission: true, 
      requestSoundPermission: true, 
      onDidReceiveLocalNotification: (id, title, body, payload) async {

      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsIOS,
    );

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Bogota')); 

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse, 
    );
  }

  
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    
    final String? payload = notificationResponse.payload;
    if (payload != null && payload.isNotEmpty) {
      print('Payload de la notificación: $payload');
    }
  }

  Future<void> showNotification({
    required int id, 
    required String title,
    required String body,
    String? payload, 
  }) async {

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'equilibria_channel_id',
      'Equilibria Notifications',
      channelDescription: 'Notificaciones sobre el balance de actividades y pausas activas.',
      importance: Importance.max, 
      priority: Priority.high, 
      showWhen: false, 
      ticker: 'ticker_text', 
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();


    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
      macOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}