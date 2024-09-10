import 'package:flutter/material.dart';
import 'package:flutter_ai_photo_analyze/providers/gemini_provider_impl.dart';
import 'package:flutter_ai_photo_analyze/providers/ia_provider.dart';
import 'package:flutter_ai_photo_analyze/widgets/button/button_component.dart';
import 'package:flutter_ai_photo_analyze/widgets/pick_image/pick_image_component.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final IaProvider provider = GeminiProviderImpl();

  ValueNotifier<String?> image = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Page'),
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

                        final analysis =
                            await provider.getAnalysisByImage(image.value!);

                        if (context.mounted) {
                          Navigator.pushNamed(
                            context,
                            '/result',
                            arguments: {
                              'analysis': analysis,
                              'image': image.value,
                            },
                          );

                          isLoading.value = false;
                        }
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
