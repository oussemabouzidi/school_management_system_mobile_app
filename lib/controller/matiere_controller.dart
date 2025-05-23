import 'package:get/get.dart';
import 'package:my_app3/models/Matiere.dart';
import 'package:my_app3/services/Services.dart';

class MatiereController extends GetxController {
  final Service _matiereService = Service();

  RxList<Matiere> matieres = <Matiere>[].obs;
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMatieres();
  }

  Future<void> fetchMatieres() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final List<Matiere> fetchedMatieres = await _matiereService.getMatieres();
      matieres.value = fetchedMatieres;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
