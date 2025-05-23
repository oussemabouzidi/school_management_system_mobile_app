import 'package:get/get.dart';
import 'package:my_app3/models/User.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/shared/SharedPrefsService.dart';

class LoginController extends GetxController {
  final Service service = Service();

  // initial empty object user
  late Rx<User> _user = Rx<User>(
    User(id: 0, role: ''),
  );

  // getter for User
  User get user => _user.value;

  // variables
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchUser({String? email, String? pwd}) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final result = await service.getUserLogin(email, pwd);
      _user.value = result;

      // variables for shared preferences
      String id = _user.value.id.toString();
      String role = _user.value.role;

      await SharedPrefsService.saveUser(id, role);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
