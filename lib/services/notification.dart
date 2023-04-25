import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class NotificationService {
  static Future<void> initalizeNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'glucoWizard1',
              channelName: 'GlucoWizard notifications',
              channelDescription: 'GlucoWizard Application Notifications',
              defaultColor: Color(0xFF9D50DD),
              importance: NotificationImportance.High,
              ledColor: Colors.white,
              playSound: true,
              enableVibration: true,
              channelShowBadge: true),
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'group 1')
        ],
        debug: true);
    // await AwesomeNotifications()
    //     .isNotificationAllowed()
    //     .then((isAllowed) async {
    //   if (!isAllowed) {
    //     await AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
      //onNotificationDisplayedMethod: onNotificationDisplayedMethod
    );
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onActionReceivedMethod');
    void _cancelAlarm() async {
      await AndroidAlarmManager.oneShot(
          const Duration(seconds: 0), 0, _stopRingtone,
          exact: true, wakeup: true);
    }
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('onDismissActionReceivedMethod');
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('onNotificationCreatedMethod');
  }

  // static Future<void> onNotificationDisplayedMethod(
  //     ReceivedNotification receivedNotification) async {
  //   debugPrint('onNotificationDisplayedMethod');
  //   final payload = receivedNotification.payload ?? {};
  //   if (payload["navigate"] == "true") {}
  // }

  static Future<void> showNotification(
      {required final String title,
      required final String body,
      final String? summary,
      final Map<String, String>? payload,
      final ActionType actionType = ActionType.Default,
      final NotificationLayout notificationLayout = NotificationLayout.Default,
      final NotificationCategory? category,
      final String? bigPicture,
      final List<NotificationActionButton>? actionButtons,
      final bool scheduled = false,
      final int? interval}) async {
    assert(!scheduled || (scheduled && interval != null));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: -1,
          channelKey: 'glucoWizard1',
          title: title,
          body: body,
          summary: summary,
          payload: payload,
          notificationLayout: notificationLayout,
          category: category,
          bigPicture: bigPicture),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval!,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true)
          : null,
    );
  }

  static _stopRingtone() async {
    await FlutterRingtonePlayer.stop();
  }
}
