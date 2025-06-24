// lib/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz; // Importa los datos de zona horaria

class NotificationService {
  
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Configuración para Android
     (drawable, mipmap)
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuración para iOS/macOS
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true, // Solicitar permiso para mostrar alertas
      requestBadgePermission: true, // Solicitar permiso para actualizar el badge de la app
      requestSoundPermission: true, // Solicitar permiso para reproducir sonidos
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // Callback para notificaciones recibidas mientras la app está en primer plano (solo iOS <= 9)
        // Puedes manejar acciones aquí si es necesario
      },
    );

    // Configuración general para todas las plataformas
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsIOS, // Mismo para macOS
    );

    // Inicializa los datos de zona horaria globalmente
    tz.initializeTimeZones();
    // Establece la ubicación de la zona horaria local.
    // Es importante para las notificaciones programadas. Puedes ajustarla a la zona horaria de Colombia.
    tz.setLocalLocation(tz.getLocation('America/Bogota')); // Ejemplo para Bogotá, Colombia

    // Inicializa el plugin de notificaciones con las configuraciones
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse, // Para responder a toques en notificaciones
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotificationResponse, // Para responder en segundo plano (Android)
    );
  }

  
  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    
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
