import 'package:flutter/cupertino.dart';
import 'package:money_tracker/login/model/user_model.dart';
import 'package:money_tracker/login/service/database_service.dart';
import 'package:money_tracker/shard/app_util.dart';


class AuthProvider extends ChangeNotifier {
  DatabaseService databaseService;

  AuthProvider(this.databaseService);

  bool isVisible = false;
  bool isLoading = false;
  String? error;

  void setPasswordFieldStatus() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future registerUser(User user) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await databaseService.registerUser(user);
    } catch (e) {
      error = e.toString();
      AppUtil.showToast(error!);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> isUserExists(User user) async {
    try {
      isLoading = true;
      notifyListeners();
      error = null;
    } catch (e) {
      error = e.toString();
      AppUtil.showToast(error!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return false;
  }
}
