import 'package:camera/camera.dart';
import 'package:get/get.dart';

class AppCameraController extends GetxController {
  List<CameraDescription>? cameras;

  @override
  void onInit() {
    super.onInit();
    initCameras();
  }

  Future<void> initCameras() async {
    try {
      cameras = await availableCameras();
    } catch (e) {
      print("Error getting cameras: $e");
    }
  }
}
