// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ai_photo_analyze/widgets/generic_dialog.dart';
import 'package:flutter_ai_photo_analyze/widgets/pick_image/widgets/option_label_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickImageWidget extends StatefulWidget {
  final Function(String?) onChanged;

  const PickImageWidget({
    super.key,
    required this.onChanged,
  });

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  String? imageFilePath;

  Future<void> pick(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        setState(() => imageFilePath = pickedFile.path);
      }
    } on PlatformException catch (_) {
      final sourceString =
          (source == ImageSource.camera) ? "câmera" : "galeria";

      showDialog(
        context: context,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: GenericDialog(
              icon: Icons.error_outline,
              content:
                  "Você deve permitir o acesso à $sourceString, faça isso nas configurações do seu dispositivo",
              firstButtonTitle: "Abrir configurações",
              onTapFirstButton: () {
                openAppSettings();
                Navigator.pop(context);
              },
            ),
          );
        },
      );
    }
  }

  Future<void> showPickImageBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  OptionLabelWidget(
                    icon: Icons.image_outlined,
                    title: "Abrir galeria",
                    onTap: () async {
                      Navigator.pop(context);
                      await pick(ImageSource.gallery);
                      widget.onChanged(imageFilePath);
                    },
                  ),
                  const SizedBox(height: 8.0),
                  OptionLabelWidget(
                    icon: Icons.camera_alt_outlined,
                    title: "Abrir câmera",
                    onTap: () async {
                      Navigator.pop(context);
                      await pick(ImageSource.camera);
                      widget.onChanged(imageFilePath);
                    },
                  ),
                  const SizedBox(height: 8.0),
                  if (imageFilePath != null && imageFilePath!.isNotEmpty)
                    OptionLabelWidget(
                      icon: Icons.delete_forever_outlined,
                      title: "Remover imagem",
                      onTap: () {
                        setState(() => imageFilePath = null);
                        Navigator.pop(context);
                        widget.onChanged(imageFilePath);
                      },
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showPickImageBottomSheet(context),
      child: Stack(
        children: [
          (imageFilePath != null)
              ? Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imageFilePath!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  height: 200.0,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[600],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate_outlined,
                        size: 32.0,
                      ),
                      SizedBox(height: 16.0),
                      FittedBox(
                        child: Text(
                          "Clique aqui para adicionar uma imagem",
                        ),
                      ),
                    ],
                  ),
                ),
          if (imageFilePath != null)
            Positioned(
              right: 8.0,
              top: 8.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
