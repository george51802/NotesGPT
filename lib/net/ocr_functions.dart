import 'dart:convert';
import 'dart:io';
import 'package:googleapis/vision/v1.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

Future<String> performOCR(File imageFile) async {
  // Authenticate with Google Cloud Vision API
  const apiKey = 'AIzaSyDUwMxhnKvwk96wAHp_ylobG6w82EffqQU';
  final client = await auth.clientViaApiKey(apiKey);
  final visionApi = VisionApi(client);

  // Read image file as bytes
  final imageBytes = await imageFile.readAsBytes();

  // Convert image bytes to base64-encoded string
  final base64Image = base64Encode(imageBytes);

  // Create image annotation request
  final request = AnnotateImageRequest()
    ..image = Image()
    ..image!.content = base64Image
    ..features = [
      Feature()
        ..maxResults = 1
        ..type = 'TEXT_DETECTION'
    ];

  // Perform OCR on image using Google Cloud Vision API
  final response = await visionApi.images.annotate(
    BatchAnnotateImagesRequest()..requests = [request],
  );

  // Extract text from OCR response
  final text = response.responses!.first.textAnnotations!.first.description;

  if (text != null) {
    return text;
  } else {
    throw Exception('OCR response is null');
  }
}

void main(List<String> args) async {
  const imagePath =
      '/Users/nathansanchez/Desktop/Screenshot 2023-04-05 at 2.29.33 PM.png';
  final imageFile = File(imagePath);
  final text = await performOCR(imageFile);
  print(text);
}
