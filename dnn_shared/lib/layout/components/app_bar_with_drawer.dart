import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class AppBarWithDrawer extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithDrawer({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppBarDrawerClipper(),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.only(top: 10),
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  PictureWidget(
                    img: accountController.userPhoto,
                    size: const Size(45, 45),
                  ),
                  const MenuButtom(color: AppColors.whiteColor),
                ],
              ),
              SizedBox(
                width: 120,
                height: 40,
                child: SvgPicture.asset(
                  MediaRes.horizontalBrancoAzulClaro,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.blueColor,
      ),
    );
  }
}

class AppBarDrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 15.0;
    Path path = Path()
      ..lineTo(0, size.height - radius)
      ..quadraticBezierTo(0, size.height, radius, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
