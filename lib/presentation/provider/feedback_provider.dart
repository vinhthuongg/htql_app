import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackProvider extends ChangeNotifier {
  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile> _images = [];

  List<XFile> get images => List<XFile>.unmodifiable(_images);
  bool get hasImages => _images.isNotEmpty;

  Future<void> pickImages() async {
    final selectedImages = await _imagePicker.pickMultiImage(imageQuality: 85);
    if (selectedImages.isEmpty) return;

    _images.addAll(selectedImages);
    notifyListeners();
  }

  void removeImage(XFile image) {
    _images.removeWhere((item) => item.path == image.path);
    notifyListeners();
  }

  void clearImages() {
    _images.clear();
    notifyListeners();
  }
}
