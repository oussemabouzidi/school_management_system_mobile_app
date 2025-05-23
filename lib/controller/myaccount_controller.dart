import 'package:get/get.dart';
import 'package:my_app3/services/Services.dart';

class MyaccountController extends GetxController {
  final Service service = Service();
  RxList<Map<String, dynamic>> eleveProfile = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final List<Map<String, dynamic>> fetchedData =
          await service.getElevesProfiles(1);
      eleveProfile.value = fetchedData;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
