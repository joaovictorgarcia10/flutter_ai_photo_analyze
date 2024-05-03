// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_ai_photo_analyze/pages/result_page.dart';
import 'package:flutter_ai_photo_analyze/providers/gemini_provider.dart';
import 'package:flutter_ai_photo_analyze/widgets/button/button_component.dart';
import 'package:flutter_ai_photo_analyze/widgets/pick_image/pick_image_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final geminiProvider = GeminiProvider();

  ValueNotifier<String?> image = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimatedBuilder(
            animation: Listenable.merge([image, isLoading]),
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PickImageWidget(
                    onChanged: (pickedImage) => image.value = pickedImage,
                  ),
                  const SizedBox(height: 50.0),
                  if (image.value != null)
                    ButtonComponent(
                      isLoading: isLoading.value,
                      title: "Enviar para análise",
                      onTap: () async {
                        isLoading.value = true;

                        final analysis = await geminiProvider
                            .sendImageToGemini(image.value!);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(
                              analysis: analysis!,
                              image: image.value!,
                            ),
                          ),
                        );

                        isLoading.value = false;
                      },
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
