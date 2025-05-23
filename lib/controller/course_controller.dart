import 'package:get/get.dart';
import 'package:my_app3/models/Course.dart';
import 'package:my_app3/shared/SharedPrefsService.dart';
import 'package:my_app3/services/Services.dart';

class CourseController extends GetxController {
  final Service service = Service();

  late Rx<Course> course = Rx<Course>((Course(
    id: 0,
    title: '',
    details: '',
    ressources: [],
    type: '',
    week: 0,
    created_at: '',
    video_url: '',
    class_id: 0,
    matiere_id: 0,
  )));

  RxList<Course> courses = <Course>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchData(int matiere_id) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      String id_eleve = (await SharedPrefsService.getUserId()) ?? '0';
      final result = await service.getCourse(int.parse(id_eleve), matiere_id);
      course.value = result;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
