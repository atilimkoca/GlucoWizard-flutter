import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:glucowizard_flutter/components/reminder.dart';
import 'package:glucowizard_flutter/main.dart';
import 'package:glucowizard_flutter/models/alarm_info.dart';
import 'package:glucowizard_flutter/models/gradient_colors.dart';
import 'package:glucowizard_flutter/providers/alarms_provider.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:glucowizard_flutter/providers/reminder_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/profile_provider.dart';
import '../services/notification.dart';
import 'alarms_page.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> with TickerProviderStateMixin {
  static final _formKey = GlobalKey<FormState>();
  bool _switch = false;
  bool _isRepeatSelected = false;
  DateTime? _alarmTime;
  late String _alarmTimeString;
  int? _currentTabIndex;

  @override
  Widget build(BuildContext context) {
    _currentTabIndex = context.watch<ReminderProvider>().currentTabIndex ?? 0;
    TabController _tabController =
        TabController(length: 2, vsync: this, initialIndex: _currentTabIndex!);

    //print(_currentTabIndex);
    List<AlarmInfo> alarms = context.watch<AlarmsProvider>().alarmInfo ?? [];
    var alarmId = context.watch<AlarmsProvider>().alarmId;
    TextEditingController _alarmTitleController = TextEditingController();
    var formatter = new DateFormat.Hm();
    print(_currentTabIndex);
    return Column(children: [
      TabBar(
        onTap: (value) {
          //print(value);
          context.read<ReminderProvider>().setCurrentTabIndex(value);
        },
        indicatorColor: Color(0xffCCA8E9),
        indicatorWeight: 5,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        controller: _tabController,
        tabs: [
          Tab(
              icon: Icon(
            Icons.alarm,
            size: 30,
          )),
          Tab(icon: Icon(Icons.calendar_month, size: 30)),
        ],
      ),
      SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.75,
        child: TabBarView(controller: _tabController, children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              children: alarms
                  .map<Widget>((alarm) => Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color:
                                    alarm.gradientColors!.last.withOpacity(0.4),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            color: Colors.white,
                                            fontFamily: 'avenir'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // Icon(
                              //   alarm.isRepeating!
                              //       ? Icons.repeat
                              //       : Icons.looks_one,
                              //   color: Colors.white,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Icon(
                                          alarm.isRepeating!
                                              ? Icons.repeat
                                              : Icons.looks_one,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                            formatter
                                                .format(alarm.alarmDateTime!),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'avenir',
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      AlarmInfo data = AlarmInfo(
                                        alarmId: alarmId,
                                        alarmDateTime: _alarmTime,
                                        gradientColors: GradientColors.sunset,
                                        alarmTitle: alarm.alarmTitle,
                                      );
                                      var loginProvider =
                                          Provider.of<LoginPageProvider>(
                                              context,
                                              listen: false);
                                      context
                                          .read<AlarmsProvider>()
                                          .deleteAlarm(
                                              loginProvider.userId!, alarm);
                                      _cancelAlarm(alarm.alarmId!);

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
                  color: Color(0xffCCA8E9),
                  borderType: BorderType.RRect,
                  radius: Radius.circular(24),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Color(0xffC3BEF0)),
                    child: MaterialButton(
                      onPressed: () {
                        var profileProvider = Provider.of<ProfileProvider>(
                            context,
                            listen: false);
                        print(profileProvider.users.totalId!);
                        // _scheduleAlarm();
                        // print('Add Alarm');
                        _alarmTimeString =
                            DateFormat('HH:mm').format(DateTime.now());
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
                              return StatefulBuilder(
                                  builder: (context, setModalState) {
                                return Container(
                                  padding: const EdgeInsets.all(32),
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          var selectedTime =
                                              await showTimePicker(
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
                                              _alarmTimeString =
                                                  DateFormat('HH:mm')
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
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .repeat),
                                        trailing: Switch(
                                          onChanged: (value) {
                                            setModalState(() {
                                              _isRepeatSelected = value;
                                              print(_isRepeatSelected);
                                            });
                                          },
                                          value: _isRepeatSelected,
                                        ),
                                      ),
                                      Form(
                                        key: _formKey,
                                        child: ListTile(
                                          title: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .alarm_error;
                                              }
                                              return null;
                                            },
                                            controller: _alarmTitleController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  AppLocalizations.of(context)!
                                                      .alarm_name,
                                            ),
                                          ),
                                        ),
                                      ),
                                      FloatingActionButton.extended(
                                        onPressed: () async {
                                          bool _validate =
                                              _formKey.currentState!.validate();
                                          if (!_validate) {
                                            return;
                                          } else {
                                            var alarmInfo = AlarmInfo(
                                                alarmDateTime: _alarmTime ??
                                                    DateTime.now(),
                                                gradientColors:
                                                    GradientColors.sky,
                                                alarmTitle:
                                                    _alarmTitleController
                                                            .text.isEmpty
                                                        ? ''
                                                        : _alarmTitleController
                                                            .text,
                                                alarmId: alarmId);
                                            context
                                                .read<AlarmsProvider>()
                                                .setAlarmId(alarmId);

                                            //AwesomeNotifications().cancelAllSchedules();
                                            onSaveAlarm(alarmInfo);
                                          }
                                        },
                                        icon: Icon(Icons.alarm),
                                        label: Text(
                                            AppLocalizations.of(context)!.save),
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
                          Icon(Icons.add_alarm, color: Colors.white, size: 35),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            AppLocalizations.of(context)!.add_alarm,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'avenir',
                                fontSize: 22),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]).toList(),
            ),
          ),
          Reminder(),
        ]),
      )
    ]);
  }

  void _cancelAlarm(int alarmId) async {
    AwesomeNotifications().cancelSchedule(alarmId);
  }

  Random random = Random();

  Future<void> _scheduleAlarm(
      DateTime scheduleAlarmDateTime, AlarmInfo alarmInfo,
      {bool? isRepeating}) async {
    var loginProvider = Provider.of<LoginPageProvider>(context, listen: false);
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var formatter = DateFormat.Hm();
    // print('schedule alarm');
    // final now = DateTime.now();
    // final alarmTime = DateTime.now().add(Duration(seconds: 5));

    // await AndroidAlarmManager.oneShotAt(
    //     scheduleAlarmDateTime, random.nextInt(10000), _onAlarm,
    //     exact: true, wakeup: true);
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: profileProvider.users.totalId! + 1,
            channelKey: 'glucoWizard1',
            title: formatter.format(alarmInfo.alarmDateTime!),
            body: alarmInfo.alarmTitle),
        schedule: NotificationCalendar(
            hour: alarmInfo.alarmDateTime!.hour,
            minute: alarmInfo.alarmDateTime!.minute,
            second: alarmInfo.alarmDateTime!.second,
            repeats: isRepeating ?? false));
    AlarmInfo alarminfo = AlarmInfo(
        alarmDateTime: alarmInfo.alarmDateTime,
        alarmTitle: alarmInfo.alarmTitle,
        gradientColors: alarmInfo.gradientColors,
        alarmId: alarmInfo.alarmId);
    context.read<AlarmsProvider>().addAlarms(
        loginProvider.userId!, alarmInfo, profileProvider.users.totalId! + 1);
    context.read<ProfileProvider>().getInfos(loginProvider.userId!);
  }

  Future<void> onSaveAlarm(AlarmInfo alarminfo) async {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    DateTime? scheduleAlarmDateTime;
    _alarmTime = _alarmTime ?? DateTime.now();
    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else
      scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));

    var alarmInfo = AlarmInfo(
        alarmDateTime: scheduleAlarmDateTime!,
        gradientColors: [Colors.blue, Colors.indigo],
        alarmTitle: alarminfo.alarmTitle,
        alarmId: profileProvider.users.totalId! + 1,
        isRepeating: _isRepeatSelected);
    //alarms.add(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      _scheduleAlarm(
        scheduleAlarmDateTime,
        alarmInfo,
        isRepeating: _isRepeatSelected,
      );
    }
    Navigator.pop(context);
    setState(() {
      //alarms = alarms;
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
