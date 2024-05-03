import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyD0sfZecCtPevITofkMu-2JubWnge7IECY';

class GeminiProvider {
  Future<String?> sendImageToGemini(String imagePath) async {
    final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);

    const prompt =
        'Você é um especialista em carros e está esperando receber uma imagem de um carro para avaliar. Você deve escrever um texto descrevendo o carro e suas características específicas como: cor, modelo, ano, etc. e estipular um valor de revenda baseado na média do mercado.';

    final List<int> imageInBytes = await File(imagePath).readAsBytes();
    final Uint8List bytes = Uint8List.fromList(imageInBytes);

    final content = [
      Content.multi([
        TextPart(prompt),
        DataPart('image/jpeg', bytes),
      ])
    ];

    final response = await model.generateContent(content);
    return response.text;
  }
}
