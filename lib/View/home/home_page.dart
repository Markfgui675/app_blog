import 'package:app_blog/View/inicio/inicio_page.dart';
import 'package:app_blog/View/notificacao/notifica_page.dart';
import 'package:app_blog/View/resources/assets_manager.dart';
import 'package:app_blog/View/resources/strings_manager.dart';
import 'package:app_blog/View/resources/values_manager.dart';
import 'package:app_blog/View/salvos/salvo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:line_icons/line_icon.dart';
import '../conta/conta_page.dart';
import '../resources/color_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25))
  );

  var scaffoldKey = GlobalKey<ScaffoldState>();

  SnakeShape snakeShape = SnakeShape.circle;

  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

  bool showSelectedLabels = false;
  bool showUnselectedLabes = false;

  int _selectedItemPosition = 0;

  final List<Widget> _pages = [
    InicioPage(),
    SalvoPage(),
    NotificationPage(),
    ContaPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: ColorManager.branco,
        elevation: 0,
        toolbarHeight: AppSize.s85,
        actions: [
          GestureDetector(
            onTap: () => setState(() {
              _selectedItemPosition = 3;
            }),
            child: const Padding(
              padding: EdgeInsets.all(AppPadding.p12),
              child: CircleAvatar(
                backgroundColor: ColorManager.preto,
                maxRadius: AppSize.s25,
              ),
            ),
          )
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              padding: const EdgeInsets.all(AppPadding.p12),
              icon: Image.asset(AssetsManager.menu, width: AppSize.s48, height: AppSize.s48,),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.branco,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      drawer: Drawer(
        backgroundColor: ColorManager.branco,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(AppSize.s70))
        ),
        child: Container(),
      ),
      body: _pages[_selectedItemPosition],
      bottomNavigationBar: SnakeNavigationBar.color(
        //height: 80,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: const EdgeInsets.all(AppPadding.p12),
        backgroundColor: ColorManager.preto,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: ColorManager.branco,
        selectedItemColor: snakeShape == SnakeShape.indicator ? null : ColorManager.marrom,
        unselectedItemColor: ColorManager.branco,

        ///configuration for SnakeNavigationBar.gradient
        // snakeViewGradient: selectedGradient,
        // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
        // unselectedItemGradient: unselectedGradient,

        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabes,

        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(
            icon: LineIcon.home(),
            label: AppStrings.inicio
          ),
          BottomNavigationBarItem(
            icon: LineIcon.bookmarkAlt(),
            label: AppStrings.salvos
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: AppStrings.notificacoes
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: AppStrings.conta
          ),
        ],

      ),
    );
  }
}

