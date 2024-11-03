import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    // el Notch es el espacio no visible de los diferentes dispositivos andriod y ios
    final bool hasNotch = MediaQuery.of(context).viewPadding.top >
        35; //  si tengo mas de un padding:35 tengo un notch

    // Con Platform identifico el dispositivo que tengo
    //bool isAndroid = Platform.isAndroid;
    //bool isIOS = Platform.isIOS;
    return NavigationDrawer(
        selectedIndex: navDrawerIndex, // item seleccionado en el navDrawer
        onDestinationSelected: (value) {
          // nuevo item seleccionado en el navDrawer
          setState(() {
            navDrawerIndex = value;
          });

          final menuItem = appMenuItems[value];
          context.push(menuItem.link);
          if(widget.scaffoldKey.currentState!.isDrawerOpen){
            widget.scaffoldKey.currentState?.closeDrawer(); // si existe el drawer abierto lo cierra
          }
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 10 : 20, 16, 10),
            child: const Text(
              'Menú principal',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...appMenuItems.sublist(0, 3).map((item) =>
              NavigationDrawerDestination(
                  icon: Icon(item.icon), label: Text(item.title))),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text(
              'Más opciones',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...appMenuItems.sublist(3).map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon), label: Text(item.title))),
        ]);
  }
}
