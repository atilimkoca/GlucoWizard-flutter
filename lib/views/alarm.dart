import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:glucowizard_flutter/main.dart';
import 'package:glucowizard_flutter/models/alarm_info.dart';
import 'package:glucowizard_flutter/models/gradient_colors.dart';
import 'package:glucowizard_flutter/providers/alarms_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/notification.dart';
import 'alarms_page.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  bool _switch = false;
  bool _isRepeatSelected = false;
  DateTime? _alarmTime;
  late String _alarmTimeString;

  @override
  Widget build(BuildContext context) {
    var alarmId = context.watch<AlarmsProvider>().alarmId;
    TextEditingController _alarmTitleController = TextEditingController();
    var formatter = new DateFormat.Hm();

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      children: alarms
          .map<Widget>((alarm) => Container(
                margin: const EdgeInsets.only(bottom: 32),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: alarm.gradientColors!.last.withOpacity(0.4),
                        blurRadius: 8,
                        spreadRadius: 4,
                        offset: Offset(4, 4))
                  ],
                  gradient: LinearGradient(
                      colors: alarm.gradientColors!,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.label,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                alarm.alarmTitle!,
                                style: TextStyle(
                                    color: Colors.white, fontFamily: 'avenir'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatter.format(alarm.alarmDateTime),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'avenir',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700)),
                          IconButton(
                            onPressed: () async {
                              AndroidAlarmManager.cancel(11);
                              _cancelAlarm();

                              setState(() {
                                alarms.remove(alarm);
                              });
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ))
          .followedBy([
        DottedBorder(
          dashPattern: [5, 4],
          strokeWidth: 2,
          color: Colors.grey,
          borderType: BorderType.RRect,
          radius: Radius.circular(24),
          child: Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Color(0xFF444974)),
            child: MaterialButton(
              onPressed: () {
                // _scheduleAlarm();
                // print('Add Alarm');
                _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
                showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setModalState) {
                        return Container(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              TextButton(
                                onPressed: () async {
                                  var selectedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (selectedTime != null) {
                                    final now = DateTime.now();
                                    var selectedDateTime = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        selectedTime.hour,
                                        selectedTime.minute);
                                    _alarmTime = selectedDateTime;
                                    setModalState(() {
                                      _alarmTimeString = DateFormat('HH:mm')
                                          .format(selectedDateTime);
                                    });
                                  }
                                },
                                child: Text(
                                  _alarmTimeString,
                                  style: TextStyle(fontSize: 32),
                                ),
                              ),
                              ListTile(
                                title: TextField(
                                  controller: _alarmTitleController,
                                  decoration: InputDecoration(
                                    hintText: 'Alarm Name',
                                  ),
                                ),
                              ),
                              FloatingActionButton.extended(
                                onPressed: () async {
                                  var alarmInfo = AlarmInfo(
                                      _alarmTime ?? DateTime.now(),
                                      gradientColors: GradientColors.sky,
                                      alarmTitle:
                                          _alarmTitleController.text.isEmpty
                                              ? ''
                                              : _alarmTitleController.text,
                                      alarmId: alarmId);
                                  context
                                      .read<AlarmsProvider>()
                                      .setAlarmId(alarmId);
                                  //AwesomeNotifications().cancelAllSchedules();
                                  onSaveAlarm(alarmInfo);
                                },
                                icon: Icon(Icons.alarm),
                                label: Text('Save'),
                              ),
                            ],
                          ),
                        );
                      });
                    });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/add_alarm.png',
                    scale: 1.5,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Add Alarm',
                    style: const TextStyle(
                        color: Colors.white, fontFamily: 'avenir'),
                  )
                ],
              ),
            ),
          ),
        )
      ]).toList(),
    );
  }

  void _cancelAlarm() async {
    AndroidAlarmManager.cancel(11);
    await AndroidAlarmManager.oneShot(
        const Duration(seconds: 0), 0, _stopRingtone,
        exact: true, wakeup: true);
  }

  Random random = Random();
  List<AlarmInfo> alarms = [
    AlarmInfo(
      DateTime.now().add(const Duration(hours: 1)),
      alarmTitle: "Alarm 1",
      gradientColors: GradientColors.fire,
    ),
    AlarmInfo(
      DateTime.now().add(const Duration(hours: 1)),
      alarmTitle: "Alarm 1",
      gradientColors: GradientColors.fire,
    ),
    AlarmInfo(
      DateTime.now().add(const Duration(hours: 1)),
      alarmTitle: "Alarm 1",
      gradientColors: GradientColors.fire,
    ),
    AlarmInfo(
      DateTime.now().add(const Duration(hours: 1)),
      alarmTitle: "Alarm 1",
      gradientColors: GradientColors.fire,
    ),
    AlarmInfo(
      DateTime.now().add(const Duration(hours: 1)),
      alarmTitle: "Alarm 1",
      gradientColors: GradientColors.fire,
    ),
    AlarmInfo(
      DateTime.now().add(const Duration(hours: 1)),
      alarmTitle: "Alarm 1",
      gradientColors: GradientColors.fire,
    ),
    AlarmInfo(
      DateTime.now().add(const Duration(hours: 1)),
      alarmTitle: "Alarm 1",
      gradientColors: GradientColors.fire,
    ),
    AlarmInfo(
      DateTime.now().add(const Duration(hours: 1)),
      alarmTitle: "Alarm 1",
      gradientColors: GradientColors.fire,
    ),
  ];
  Future<void> _scheduleAlarm(
      DateTime scheduleAlarmDateTime, AlarmInfo alarmInfo,
      {bool? isRepeating}) async {
    print('schedule alarm');
    final now = DateTime.now();
    final alarmTime = DateTime.now().add(Duration(seconds: 5));

    await AndroidAlarmManager.oneShotAt(
        scheduleAlarmDateTime, random.nextInt(10000), _onAlarm,
        exact: true, wakeup: true);
  }

  Future<void> onSaveAlarm(AlarmInfo alarminfo) async {
    DateTime? scheduleAlarmDateTime;
    _alarmTime = _alarmTime ?? DateTime.now();
    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
      scheduleAlarmDateTime!,
      gradientColors: [Colors.blue, Colors.indigo],
      alarmTitle: alarminfo.alarmTitle,
      alarmId: 11,
    );
    alarms.add(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      _scheduleAlarm(
        scheduleAlarmDateTime,
        alarmInfo,
      );
    }
    Navigator.pop(context);
    setState(() {
      alarms = alarms;
    });
  }
}

_onAlarm() async {
  print('************');
  var formatter = DateFormat.Hm();

  //final ringtoneUri = await getRingtoneUri();
  print('alarm');

  NotificationService.showNotification(
      body: 'test1',
      title: 'test2',
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
  );
}

_stopRingtone() async {
  await AndroidAlarmManager.cancel(11);
  await FlutterRingtonePlayer.stop();
}
