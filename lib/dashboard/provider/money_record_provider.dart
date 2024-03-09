import 'package:flutter/cupertino.dart';
import 'package:money_tracker/dashboard/model/money_record_model.dart';
import 'package:money_tracker/login/service/database_service.dart';
import 'package:money_tracker/shard/app_util.dart';

class MoneyRecordProvider extends ChangeNotifier {
  List<MoneyRecord> moneyRecordsList = [];

  DatabaseService databaseService;

  bool isLoading = false;
  String? error;

  MoneyRecordProvider(this.databaseService);

  Future addMoneyRecord(MoneyRecord moneyRecord) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      await databaseService.addMoneyRecord(moneyRecord);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future editMoneyRecord(MoneyRecord moneyRecord) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      await databaseService.editMoneyRecord(moneyRecord);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future getMoneyRecord() async {
    try {
      error = null;
      isLoading = true;
      moneyRecordsList = await databaseService.getMoneyRecords();
      notifyListeners();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future deleteMoneyRecord(int id) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      await databaseService.deleteMoneyRecord(id);
    } catch (e) {
      error = e.toString();
      AppUtil.showToast(error!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
