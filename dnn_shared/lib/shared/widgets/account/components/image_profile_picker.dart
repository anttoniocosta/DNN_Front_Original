import 'dart:io';

import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfilePicker extends StatefulWidget {
  const ImageProfilePicker({super.key, required this.size});

  final double size;

  @override
  State<ImageProfilePicker> createState() => _ImageProfilePickerState();
}

class _ImageProfilePickerState extends State<ImageProfilePicker> {
  XFile? image;
  Future _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      maxHeight: 512,
      maxWidth: 512,
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  Future _pickImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(
      maxHeight: 512,
      maxWidth: 512,
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              SizedBox(
                width: widget.size,
                height: widget.size,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: Container(
                    child: image != null
                        ? Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                            width: widget.size,
                            height: widget.size,
                          )
                        : Image.asset(
                            MediaRes.blankImg,
                            fit: BoxFit.fill,
                            width: widget.size,
                            height: widget.size,
                          ),
                  ).toCenter,
                ),
              ),
              Positioned(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  color: AppColors.blueColor,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        CustomDialogs.simpleDialog(
                          context: context,
                          title: 'Escolha uma opção',
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Divider(),
                              PictureCaptureWidget(
                                title: 'Galeria',
                                iconData: FontAwesomeIcons.photoFilm,
                                onTap: () {
                                  _pickImageFromGallery();
                                  Navigator.of(context).pop();
                                },
                              ),
                              if (!kIsWeb)
                                PictureCaptureWidget(
                                  title: 'Câmera',
                                  iconData: FontAwesomeIcons.camera,
                                  onTap: () {
                                    _pickImageFromCamera();
                                    Navigator.of(context).pop();
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.cameraRetro,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
