import 'package:dnn_dependencies/sc_util.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key, required this.user});

  final UserAccountInfoModel user;

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  Future _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      maxHeight: 512,
      maxWidth: 512,
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedImage != null) {
      updateAccountController.uploadPhoto(pickedImage);
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
      updateAccountController.uploadPhoto(pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomRight,
            children: [
              Center(
                child: PictureWidget(
                  img: ValueNotifier<String>(
                      widget.user.photo ?? MediaRes.blankImg),
                  size: Size(185.h, 185.h),
                ),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                  side: const BorderSide(
                      color: AppColors.whiteColor,
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignCenter),
                ),
                color: AppColors.blueColor,
                child: SizedBox(
                  height: 40.h,
                  width: 40.h,
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
                    icon: SvgPicture.asset(MediaRes.edit),
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
