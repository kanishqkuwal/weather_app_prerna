
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sample_flutter_project/message_screen.dart';

class NotificationServices {

  FirebaseMessaging messaging = FirebaseMessaging.instance;
 static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  void requestNotificationPermission() async{
    NotificationSettings settings = await  messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
            print('user granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.authorized){
            print('user granted provisional permission');

    }else{
             print('user denied permission');

    }
  }


  void initLocalNotification(BuildContext context , RemoteMessage message)  async{
    var androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings
    );
    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
      onDidReceiveNotificationResponse: (payload){
            handleMessage(context, message);
      }
    );
  }
  void firebaseInit(BuildContext context){

    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification?.title.toString());
        print(message.notification?.body.toString());
        print(message.data.toString());
        print(message.data['type']);
        print(message.data['id']);

      }
      if(Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      }
      else{
        showNotification(message);
      }

    } );
  }

   Future<void> showNotification(RemoteMessage message)async{

   AndroidNotificationChannel channel = AndroidNotificationChannel(
       Random.secure().nextInt(100000).toString(),
       'High Importance Notification',
       importance:Importance.max

   );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    channel.id.toString(),
      channel.name.toString(),
        channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails= DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
     android:  androidNotificationDetails,
    );

       Future.delayed(Duration.zero,(){
         _flutterLocalNotificationsPlugin.show(
             0,
             message.notification?.title.toString(),
             message.notification?.body.toString(),
             notificationDetails);

       }

   );

   }
  Future<String> getDeviceToken() async{
   String? token = await messaging.getToken();
   return token! ;
  }

  void isTokenRefresh() async{
  messaging.onTokenRefresh.listen((event) {
    event.toString();
    print('refresh');
  });

  }

  Future<void> setupInteractMessage(BuildContext context)async {
    //when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }


    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context,event);
    });
  }


   void handleMessage(BuildContext context, RemoteMessage message){
     if(message.data['type'] == 'msg'){
       Navigator.push(context,
           MaterialPageRoute(builder:(context) => MessageScreen(
             id: message.data['id'],
        )));
     }
   }
}