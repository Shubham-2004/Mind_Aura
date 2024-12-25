import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectionService {
  static Future<String> detectFaces(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableClassification: true,
      ),
    );

    final List<Face> faces = await faceDetector.processImage(inputImage);
    await faceDetector.close();

    if (faces.isEmpty) {
      return 'No faces detected.';
    }

    String result = '';
    for (var face in faces) {
      if (face.smilingProbability != null) {
        final smile = face.smilingProbability!;
        result +=
            'Smile: ${(smile * 100).toStringAsFixed(2)}%\n'; // Smile percentage
        if (smile > 0.8) {
          result += 'Mood: Happy 😊\n';
        } else if (smile > 0.4) {
          result += 'Mood: Neutral 😐\n';
        } else {
          result += 'Mood: Sad 😔\n';
        }
      }

      if (face.leftEyeOpenProbability != null &&
          face.rightEyeOpenProbability != null) {
        final eyeOpen =
            (face.leftEyeOpenProbability! + face.rightEyeOpenProbability!) / 2;
        if (eyeOpen < 0.3) {
          result += 'Anxiety: High 😟\n';
        } else {
          result += 'Anxiety: Low 😌\n';
        }
      }
      result += '\n';
    }

    return result.trim();
  }
}
