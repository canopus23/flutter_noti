import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_noti/notification_services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationServices notificationServices = NotificationServices();



  @override
  void initState(){
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.foregroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);

    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      print('device token');
      print(value);

    });
  }


@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notification'),
      ),
      body: Center(
        child: TextButton(onPressed: () {
          notificationServices.getDeviceToken().then((value)async{
            var data = {
              'to' : value.toString(),
              'priority' : 'high',
              'notification' : {
                'title' : 'Saikat',
                'body' : 'Click on this link',
              },

              'data' : {
                'type' : 'msg' ,
                'id' : 'saikat1234'
              }

            };
            await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(data),

                headers: {
              'Content-Type' : 'application/json; charset=UTF-8',
                  'Authorization' : 'key=AAAAsbMeITM:APA91bFO53MNA4S9BuaG_c-FvueoQH0H59CRGvJKwjhP-SRxEHosS95rpRkz82Mcf_bzPnIKMXoIINqE5lEB9Vu5gpRCuZWpAt0Hb988gX-50c48plhK5axPTZrVHfDqvCibRscflBnh',

              }
            );
          });
        },
          child: const Text('Send Notification'),
        ),
      ),
    );
}


}