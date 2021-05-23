import 'package:flutter/foundation.dart';
import 'package:goodvibesoffl/models/notification_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:goodvibesoffl/services/database_service.dart';

class ReminderDbProvider with ChangeNotifier {
  List<NotificationModel> notifications = [];

  deleteReminder(int id) async {
    await DatabaseService().deleteSingleReminder(id);
    getReminder();
  }

  deleteAllTable() async {
    await DatabaseService().deleteReminderTable();
    getReminder();
  }

  deleteMultipleRecors(List<int> ids) async {
    await Future.wait<dynamic>(
        [DatabaseService().deleteMultipleRemidners(ids), getReminder()]);
  }

  addReminder({int id, String time, String day, int status}) async {
    var row = {'id': id, 'time': time, 'day': day, 'status': status};

    await Future.wait<dynamic>(
        [DatabaseService().addReminder(row), getReminder()]);
  }

  updateStatus({int id, bool status}) async {
    int stat;
    if (status == true)
      stat = 1;
    else
      stat = 0;

    await Future.wait<dynamic>([
      DatabaseService().updateReminder(status: stat, id: id),
      getReminder()
    ]);
  }

  getReminder({Database database}) async {
    var fb = await DatabaseService().getReminders();
    var a = fb.map<NotificationModel>((data) => NotificationModel.fromDb(data));

    notifications.clear();
    notifications.addAll(a);
    notifyListeners();
  }

  insertFavorite() {}
}
