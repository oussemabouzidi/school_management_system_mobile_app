import 'package:get/get.dart';
import 'package:my_app3/models/Homework.dart';
import 'package:my_app3/services/Services.dart';

class HomeworkController extends GetxController {
  final Service service = Service();

  // Make homework an Rx object so the UI can react to changes
  late Rx<Homework> _homework = Rx<Homework>(Homework(
    id: 0,
    enseignant_id: 0,
    matiere_id: 0,
    titre: '',
    description: '',
    date: DateTime.now(),
    datelimite: DateTime.now(),
    etat: '',
    compterendu: '',
    ressources: [],
  ));

  // Getter for the homework object
  Homework get homework => _homework.value;

  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchHomework({int studentId = 1, int matiereId = 1}) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final result = await service.getHomework(studentId, matiereId);
      _homework.value = result;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
