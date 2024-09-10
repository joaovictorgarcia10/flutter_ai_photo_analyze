import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_ai_photo_analyze/providers/ia_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyD0sfZecCtPevITofkMu-2JubWnge7IECY';

class GeminiProviderImpl extends IaProvider {
  @override
  Future<String?> getAnalysisByImage(String imagePath) async {
    final model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);

    final List<int> imageInBytes = await File(imagePath).readAsBytes();
    final Uint8List bytes = Uint8List.fromList(imageInBytes);

    final content = [
      Content.multi([
        TextPart(super.prompt),
        DataPart('image/jpeg', bytes),
      ])
    ];

    final response = await model.generateContent(content);
    return response.text;
  }

  @override
  Future<String?> getAnalysisByPDF(String pdfPath) async {}
}
