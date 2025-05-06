import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:my_app3/controller/wrappercontroller.dart';

class Wrapper extends StatelessWidget {
  final int initialIndex;
  final bool isConnected;

  Wrapper({super.key, this.initialIndex = 0, this.isConnected = true});

  @override
  Widget build(BuildContext context) {
    final WrapperController controller =
        Get.put(WrapperController(initialIndex: initialIndex));
    // Run only once when navigating to Wrapper
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.currentIndex.value != initialIndex) {
        controller.initWith(initialIndex, isConnected);
      }
    });

    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xFFE8F0FE),
        extendBody: true,
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: CrystalNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          height: 10,
          unselectedItemColor: Colors.white70,
          borderWidth: 2,
          outlineBorderColor: Colors.white,
          backgroundColor: Colors.black.withOpacity(0.5),
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.chat,
              unselectedIcon: IconlyLight.chat,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.category,
              unselectedIcon: IconlyLight.category,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.setting,
              unselectedIcon: IconlyLight.setting,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.profile,
              unselectedIcon: IconlyLight.profile,
              selectedColor: Colors.white,
            ),
          ],
        ),
      );
    });
  }
}
