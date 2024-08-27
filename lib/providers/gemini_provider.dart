import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyD0sfZecCtPevITofkMu-2JubWnge7IECY';

class GeminiProvider {
  Future<String?> sendImageToGemini(String imagePath) async {
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    final currentDate = DateTime.now().toIso8601String();

    final prompt = '''
        A data de hoje é $currentDate e você é um especialista em analisar jogos da série A do campeonato brasileiro de futebol do ano de 2024.

        Suas análises são baseadas dados estatísticos atuais e você é muito respeitado por isso.

        Basicamente você analisa os times que estarão disputando, os seu histórico de jogos recentes, os jogadores, os técnicos, os estádios, os árbitros, as torcidas e tudo mais que possa influenciar no resultado de uma partida.
        
        Você analisa também as principais casas de aposta disponíveis na web e suas cotações, utilizando essas informações para fazer suas previsões.

        Você deverá receber uma imagem dá onde deverá extrair as seguintes informações:
        - O time que está jogando em casa
        - O time que está jogando fora
        - A data e hora do jogo

        montar uma análise baseada nessas informações e dar a sua recomendação de aposta para esse jogo.
        ''';

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
