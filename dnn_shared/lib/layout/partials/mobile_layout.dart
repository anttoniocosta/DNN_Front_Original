import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({
    super.key,
    this.appBar,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.bodyChild,
    required this.needCenter,
    required this.needScrollView,
    this.appBarLeading,
    this.appBarActions,
    this.needAppBar = true,
    this.scrollReverse = false,
    this.drawer,
    this.title,
    this.hasActions = true,
    this.floatingAction,
    this.hasLeading = true,
    this.bottomAppBar,
    this.goToHelperSpecified,
    this.backAction,
    this.scaffoldKey,
    this.onRefresh,
    this.needPadding = true,
    this.needBounce = true,
    this.needMaxWidth = true,
    this.maxWidth,
  });

  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? bodyChild;
  final Widget? appBarLeading;
  final List<Widget>? appBarActions;
  final bool needCenter;
  final bool? needPadding;
  final bool needScrollView;
  final bool? needAppBar;
  final bool? scrollReverse;
  final Widget? drawer;
  final String? title;
  final bool? hasActions;
  final GlobalKey? scaffoldKey;
  final Widget? floatingAction;

  final bool? hasLeading;
  final bool? needBounce;
  final bool? needMaxWidth;
  final VoidCallback? goToHelperSpecified;
  final VoidCallback? backAction;
  final PreferredSizeWidget? bottomAppBar;
  final Future<void> Function()? onRefresh;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    Widget titleAppBar({String? title}) {
      if (title != null) {
        return Text(title,
            style: Fonts.titleMedium(context).copyWith(
                color: AppColors.whiteColor, fontFamily: Fonts.poppins));
      }
      return SvgPicture.asset(
        Get.isDarkMode ? MediaRes.logoAzulEscuro : MediaRes.logoOriBranco,
        width: 40,
        height: 40,
      );
    }

    Widget? leading(
        {Widget? appBarLeading,
        void Function()? backAction,
        bool? hasLeading}) {
      if (appBarLeading != null && hasLeading!) return appBarLeading;

      if (Navigator.of(context).canPop()) {
        return IconButton(
          padding: EdgeInsets.zero,
          onPressed: backAction ?? () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
            color: AppColors.whiteColor,
          ),
        );
      }
      return null;
    }

    List<Widget> actions({
      Function()? goToHelperSpecified,
      bool? hasActions,
      List<Widget>? appBarActions,
    }) {
      if (hasActions!) {
        return [
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: goToHelperSpecified ??
                  () => Get.toNamed(
                        Routes.helpers,
                        arguments: helpersController.helpers,
                      ),
              icon: SvgPicture.asset(MediaRes.help)),
          10.widthGap
        ];
      }
      if (appBarActions == null && kIsWeb) return [const SizedBox()];
      return appBarActions ?? [];
    }

    Widget bodyWidget({
      required bool needScrollView,
      Future<void> Function()? onRefresh,
      required bool needPadding,
      required bool needBounce,
    }) {
      if (onRefresh != null) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: RefreshIndicator.adaptive(
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: needPadding ? AppConstants.pdPage : EdgeInsets.zero,
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth ?? MediaQuery.sizeOf(context).width,
                  ),
                  child: bodyChild,
                ),
              ),
            ),
          ),
        );
      }

      if (needScrollView) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: SingleChildScrollView(
            physics: needBounce ? const BouncingScrollPhysics() : null,
            padding: needPadding ? AppConstants.pdPage : EdgeInsets.zero,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth ?? MediaQuery.sizeOf(context).width,
                ),
                child: bodyChild,
              ),
            ),
          ),
        );
      }

      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: needPadding ? AppConstants.pdPage : EdgeInsets.zero,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? MediaQuery.sizeOf(context).width,
              ),
              child: bodyChild,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: drawer,
        key: scaffoldKey,
        drawerEnableOpenDragGesture: false,
        appBar: needAppBar!
            ? appBar ??
                AppBar(
                  leadingWidth: 60,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  iconTheme: IconThemeData(
                      size: 20, color: Fonts.displayLarge(context).color),
                  toolbarHeight: kToolbarHeight + 50,
                  automaticallyImplyLeading: false,
                  surfaceTintColor: !Get.isDarkMode
                      ? AppColors.blueColor
                      : AppColors.midBlackColor,
                  elevation: Get.isDarkMode ? 0 : 4,
                  centerTitle: true,
                  scrolledUnderElevation: 0,
                  shadowColor: AppColors.blackLightColor.withOpacity(0.10),
                  backgroundColor: !Get.isDarkMode
                      ? AppColors.blueColor
                      : AppColors.midBlackColor,
                  leading: leading(
                    appBarLeading: appBarLeading,
                    hasLeading: hasLeading,
                    backAction: backAction,
                  ),
                  actions: actions(
                    goToHelperSpecified: goToHelperSpecified,
                    hasActions: hasActions,
                    appBarActions: appBarActions,
                  ),
                  title: titleAppBar(title: title),
                  bottom: bottomAppBar,
                )
            : null,
        body: Align(
          alignment: needCenter ? Alignment.center : Alignment.topCenter,
          child: bodyWidget(
            needScrollView: needScrollView,
            needPadding: needPadding!,
            needBounce: needBounce!,
            onRefresh: onRefresh,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet ?? const SizedBox(),
        floatingActionButton: floatingAction,
      ),
    );
  }
}
