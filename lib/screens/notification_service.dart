import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz; 

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {

  print("Notificación tocada en segundo plano con payload: ${notificationResponse.payload}");
}

class NotificationService {
  // Singleton pattern para asegurar una única instancia del servicio
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
   //(drawable, mipmap)
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse, 
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  // Método que se llama cuando se interactúa con una notificación
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    // Aquí puedes implementar la lógica para lo que sucede cuando el usuario toca la notificación.
    // Por ejemplo, navegar a una pantalla específica basada en el 'payload'.
    final String? payload = notificationResponse.payload;
    if (payload != null && payload.isNotEmpty) {
      print('Payload de la notificación: $payload');
      // Puedes añadir lógica para navegar o mostrar un diálogo aquí.
      // Por ejemplo:
      // if (payload == 'unbalanced_warning') {
      //   // Navegar a la pantalla de sugerencias de pausas activas
      // }
    }
  }

  // Método para mostrar una notificación inmediata
  Future<void> showNotification({
    required int id, // ID único para la notificación
    required String title,
    required String body,
    String? payload, // Datos adicionales que se pueden pasar con la notificación
  }) async {
    // Detalles de la notificación para Android
    // 'equilibria_channel_id' es el ID del canal (necesario para Android 8.0+)
    // 'Equilibria Notifications' es el nombre del canal visible al usuario
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'equilibria_channel_id',
      'Equilibria Notifications',
      channelDescription: 'Notificaciones sobre el balance de actividades y pausas activas.',
      importance: Importance.max, // Nivel de importancia (max es el más alto)
      priority: Priority.high, // Prioridad (high es el más alto)
      showWhen: false, // No muestra la hora de la notificación
      ticker: 'ticker_text', // Texto que aparece brevemente en la barra de estado (Android)
    );

    // Detalles de la notificación para iOS/macOS
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    // Detalles de la notificación para todas las plataformas
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
      macOS: iOSPlatformChannelSpecifics,
    );

    // Muestra la notificación
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // Puedes añadir métodos para notificaciones programadas si lo necesitas en el futuro
  // Future<void> scheduleNotification(...)
}
