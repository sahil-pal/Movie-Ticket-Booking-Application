import 'package:bigboxo_application/modules/home/repo/menu_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../model/menu.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    MenuOperations menuOpr = MenuOperations.getMenuOperationInstance();
    List<Menu> menus = menuOpr.getMenuList();
    return Container(
      height: size.height * 0.12,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menus.length,
        itemBuilder: (_, i) {
          return Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(left: 15.0, top: 10, right: 5),
            child: GestureDetector(
              onTap: () {
                //print(menus[i].name);
              },
              child: GestureDetector(
                // event for opening new page
                onTap: (){
                  
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        menus[i].asset,
                        height: 35,
                        width: 35,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      menus[i].name,
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}