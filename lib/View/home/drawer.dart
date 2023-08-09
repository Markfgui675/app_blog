import 'package:app_blog/View/common/logo.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p12),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoApp(fontSize: AppSize.s48, center: false)
          ],
        ),
      )
    );
  }
}

