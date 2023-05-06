import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:glucowizard_flutter/services/notification.dart';

import '../services/noti.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Noti.initialize(flutterLocalNotificationsPlugin);
  }

  final _formKey = GlobalKey<FormState>();
  TimeOfDay _time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: GestureDetector(
              onTap: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    _time = time;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select time:'),
                  Text('${_time.hour}:${_time.minute}'),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _scheduleAlarm();
                    }
                  },
                  child: const Text('Set Alarm'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    _cancelAlarm();
                  },
                  child: const Text('Cancel Alarm'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _scheduleAlarm() async {
    final now = DateTime.now();
    final alarmTime =
        DateTime(now.year, now.month, now.day, _time.hour, _time.minute);

    await AndroidAlarmManager.oneShotAt(alarmTime, 0, _onAlarm,
        exact: true, wakeup: true);
  }

  void _cancelAlarm() async {
    await AndroidAlarmManager.oneShot(
        const Duration(seconds: 0), 0, _stopRingtone,
        exact: true, wakeup: true);
  }
}

Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  _cancelAlarm();
}

_stopRingtone() async {
  await FlutterRingtonePlayer.stop();
}

void _onAlarm() async {
  //final ringtoneUri = await getRingtoneUri();
  print('alarm');

  NotificationService.showNotification(
      body: 'testBody',
      title: 'testTitle',
      notificationLayout: NotificationLayout.Default,
      payload: {
        "navigate": "true"
      },
      actionButtons: [
        NotificationActionButton(
            key: 'stop',
            label: 'stopAlarm',
            actionType: ActionType.SilentAction),
      ]);
  AwesomeNotifications()
      .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  FlutterRingtonePlayer.play(
    android: AndroidSounds.ringtone,
    ios: IosSounds.glass,
    looping: true,
    volume: 50.0,
    //fromAsset: 'assets/alarm.wav',
    //asAlarm: true
  );
}

// Future<String> getRingtoneUri() async {
//   final ringtoneUri = await RingtonePicker.picker();
//   return ringtoneUri;
// }

void _cancelAlarm() async {
  await AndroidAlarmManager.oneShot(
      const Duration(seconds: 0), 0, _stopRingtone,
      exact: true, wakeup: true);
}
