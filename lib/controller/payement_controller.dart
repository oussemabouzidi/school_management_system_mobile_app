import 'package:get/get.dart';
import 'package:my_app3/models/Payment.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/shared/SharedPrefsService.dart';

class PayementController extends GetxController {
  final Service service = Service();

  RxList<Payment> payements = <Payment>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchData(String type) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';
      String id = (await SharedPrefsService.getUserId()) ?? '0';

      final result = await service.getPayements(int.parse(id), type);
      payements.value = result;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
