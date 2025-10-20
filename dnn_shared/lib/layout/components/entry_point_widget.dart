import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_dependencies/sc_util.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({
    super.key,
    required this.basePage,
    required this.navbarItems,
  });

  final Widget basePage;
  final Widget navbarItems;

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with TickerProviderStateMixin {
  late Animation<double> scalAnimation;
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    _initAnimationController();
    navigationController.setAnimationController(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  ///Inicializar o controlador da animação e atribuir
  ///a forma de animação utilizada
  void _initAnimationController() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => setState(() {}));

    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );
  }

  Color _scaffoldColor() {
    return Get.isDarkMode
        ? AppColors.blackDarkColor
        : AppColors.lighterGreyColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldColor(),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      drawer: DrawerCustom(navbarItems: widget.navbarItems),
      body: Stack(
        children: [
          _BaseBodyPart(
            animation: animation,
            scalAnimation: scalAnimation,
            basePage: widget.basePage,
          ),
        ],
      ),
    );
  }
}

class _BaseBodyPart extends StatelessWidget {
  const _BaseBodyPart({
    required this.animation,
    required this.scalAnimation,
    required this.basePage,
  });

  final Animation<double> animation;
  final Animation<double> scalAnimation;
  final Widget basePage;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (_) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..setEntry(3, 2, 0.001),
          child: Transform.translate(
            offset: Offset(animation.value * 270.w, 0),
            child: Transform.scale(
              scale: scalAnimation.value,
              child: DecoratedBox(
                decoration: BoxDecoration(boxShadow: highElevation),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(animation.value * 24),
                  child: basePage,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SettingsBodyPart extends StatelessWidget {
  const _SettingsBodyPart({required this.navbarItems});

  final Widget navbarItems;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (_) {
        return AnimatedPositioned(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          left: _.isSidebarOpen.value ? 0 : 50.w,
          child: SettingSidebarWidget(navbarItems: navbarItems),
        );
      },
    );
  }
}
