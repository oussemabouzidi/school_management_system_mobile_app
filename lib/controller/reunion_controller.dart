import 'package:get/get.dart';
import 'package:my_app3/models/Reunion.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/shared/SharedPrefsService.dart';

class ReunionController extends GetxController {
  final Service service = Service();

  RxList<Reunion> reunions = <Reunion>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReunion();
  }

  Future<void> fetchReunion() async {
    try {
      isLoading.value = true;
      String id = (await SharedPrefsService.getUserId()) ?? '0';
      reunions.value = await service.getReunion(int.parse(id));
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
