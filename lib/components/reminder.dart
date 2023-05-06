import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:glucowizard_flutter/models/reminder_model.dart';
import 'package:glucowizard_flutter/providers/reminder_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/gradient_colors.dart';
import '../providers/login_provider.dart';
import '../providers/profile_provider.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  late String _alarmTimeString;
  late String _dateTimeString;
  DateTime? _alarmTime;
  DateTime? _dateTime;
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var loginProvider = Provider.of<LoginPageProvider>(context, listen: false);
    var formatter = DateFormat.Hm();
    var formatter1 = DateFormat.yMd();
    List<ReminderModel> alarms =
        context.watch<ReminderProvider>().reminder ?? [];
    var alarmId = context.watch<ReminderProvider>().alarmId;
    TextEditingController _alarmTitleController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView(
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
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 24,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  formatter.format(alarm.alarmDateTime!),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                      formatter1.format(alarm.alarmDateTime!),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'avenir',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () async {
                                ReminderModel data = ReminderModel(
                                  alarmId: alarmId,
                                  alarmDateTime: _alarmTime,
                                  gradientColors: GradientColors.sky,
                                  alarmTitle: alarm.alarmTitle,
                                );
                                var loginProvider =
                                    Provider.of<LoginPageProvider>(context,
                                        listen: false);
                                context
                                    .read<ReminderProvider>()
                                    .deleteAlarm(loginProvider.userId!, alarm);
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
                  var profileProvider =
                      Provider.of<ProfileProvider>(context, listen: false);

                  // _scheduleAlarm();
                  // print('Add Alarm');
                  _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
                  _dateTimeString =
                      DateFormat('dd.MM.yyyy').format(DateTime.now());
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () async {
                                        var selectedTime = await showDatePicker(
                                          context: context,
                                          firstDate: DateTime(2021),
                                          initialDate: DateTime.now(),
                                          lastDate: DateTime(2026),
                                        );
                                        if (selectedTime != null) {
                                          final now = DateTime.now();
                                          var selectedDateTime = DateTime(
                                              selectedTime.year,
                                              selectedTime.month,
                                              selectedTime.day,
                                              now.hour,
                                              now.minute);
                                          _dateTime = selectedDateTime;
                                          setModalState(() {
                                            _dateTimeString =
                                                DateFormat('dd.MM.yyyy')
                                                    .format(selectedDateTime);
                                          });
                                          print(_dateTimeString);
                                        }
                                      },
                                      child: Text(
                                        _dateTimeString,
                                        style: TextStyle(fontSize: 32),
                                      ),
                                    ),
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
                                            _alarmTimeString =
                                                DateFormat('HH:mm')
                                                    .format(selectedDateTime);
                                          });
                                          print(_alarmTime);
                                        }
                                      },
                                      child: Text(
                                        _alarmTimeString,
                                        style: TextStyle(fontSize: 32),
                                      ),
                                    ),
                                  ],
                                ),
                                // ListTile(
                                //   title: Text('Repeat'),
                                //   trailing: Switch(
                                //     onChanged: (value) {
                                //       setModalState(() {
                                //         _isRepeatSelected = value;
                                //         print(_isRepeatSelected);
                                //       });
                                //     },
                                //     value: _isRepeatSelected,
                                //   ),
                                // ),
                                Form(
                                  key: _formKey,
                                  child: ListTile(
                                    title: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .alarm_error;
                                        }
                                        return null;
                                      },
                                      controller: _alarmTitleController,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)!
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
                                      var alarmInfo = ReminderModel(
                                          alarmDateTime:
                                              _alarmTime ?? DateTime.now(),
                                          gradientColors: GradientColors.sky,
                                          alarmTitle:
                                              _alarmTitleController.text.isEmpty
                                                  ? ''
                                                  : _alarmTitleController.text,
                                          alarmId: alarmId);
                                      context
                                          .read<ReminderProvider>()
                                          .setAlarmId(alarmId);

                                      //AwesomeNotifications().cancelAllSchedules();
                                      onSaveAlarm(alarmInfo, profileProvider,
                                          loginProvider, context);
                                    }
                                  },
                                  icon: Icon(Icons.alarm),
                                  label:
                                      Text(AppLocalizations.of(context)!.save),
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
                      AppLocalizations.of(context)!.add_reminder,
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
    );
  }

  void _cancelAlarm(int alarmId) async {
    AwesomeNotifications().cancelSchedule(alarmId);
  }

  Future<void> _scheduleAlarm(
      DateTime scheduleAlarmDateTime,
      ReminderModel reminderModel,
      LoginPageProvider loginProvider,
      BuildContext context,
      {bool? isRepeating}) async {
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
            channelKey: 'glucoWizard',
            title: formatter.format(reminderModel.alarmDateTime!),
            body: reminderModel.alarmTitle),
        schedule: NotificationCalendar(
          year: scheduleAlarmDateTime.year,
          month: scheduleAlarmDateTime.month,
          day: scheduleAlarmDateTime.day,
          hour: reminderModel.alarmDateTime!.hour,
          minute: reminderModel.alarmDateTime!.minute,
          second: reminderModel.alarmDateTime!.second,
        ));
    ReminderModel alarminfo = ReminderModel(
        alarmDateTime: scheduleAlarmDateTime,
        alarmTitle: reminderModel.alarmTitle,
        gradientColors: reminderModel.gradientColors,
        alarmId: reminderModel.alarmId);
    context.read<ReminderProvider>().addReminder(loginProvider.userId!,
        reminderModel, profileProvider.users.totalId! + 1);
    context.read<ProfileProvider>().getInfos(loginProvider.userId!);
  }

  Future<void> onSaveAlarm(
      ReminderModel alarminfo,
      ProfileProvider profileProvider,
      LoginPageProvider loginPageProvider,
      BuildContext context) async {
    DateTime? scheduleAlarmDateTime;
    _alarmTime = _alarmTime ?? DateTime.now();
    _dateTime = _dateTime ?? DateTime.now();

    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime;
    else {
      scheduleAlarmDateTime = _alarmTime!.add(Duration(days: 1));
    }
    scheduleAlarmDateTime = DateTime(_dateTime!.year, _dateTime!.month,
        _dateTime!.day, _alarmTime!.hour, _alarmTime!.minute);
    var alarmInfo = ReminderModel(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColors: [Colors.blue, Colors.indigo],
      alarmTitle: alarminfo.alarmTitle,
      alarmId: profileProvider.users.totalId! + 1,
    );
    //alarms.add(alarmInfo);
    if (scheduleAlarmDateTime != null) {
      _scheduleAlarm(
        scheduleAlarmDateTime,
        alarmInfo,
        loginPageProvider,
        context,
      );
    }
    Navigator.pop(context);
  }
}
