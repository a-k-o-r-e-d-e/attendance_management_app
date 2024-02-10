import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utilities/app_colors.dart';
import '../utilities/string_utils.dart';

enum NavIdentifier { home, record, Class, profile }

class CustomBottomNavBar extends StatelessWidget {
  final Widget child;
  final NavIdentifier parent;

  const CustomBottomNavBar(
      {Key? key, required this.child, required this.parent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(parent.name);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: child),
          _CustomBottomNavBar(
            parent: parent,
          )
        ],
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final NavIdentifier parent;

  const _CustomBottomNavBar({Key? key, required this.parent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 15,
                offset: const Offset(4, 4))
          ]),
      width: MediaQuery.of(context).size.width,
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(NavItem.navItems.length, (index) {
          bool isActive = NavItem.navItems[index].identifier == parent;
          return InkWell(
            onTap: () {
              print("tapped");
              isActive
                  ? null
                  : context.router.replaceNamed(NavItem.navItems[index].route);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    "assets/svgs/${NavItem.navItems[index].icon}.svg",
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                        isActive ? AppColors.primary500 : AppColors.medium300,
                        BlendMode.srcIn)),
                Text(
                  StringUtils.capitalize(
                      NavItem.navItems[index].identifier.name),
                  style: TextStyle(
                      color:
                          isActive ? AppColors.primary500 : AppColors.medium300,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class NavItem {
  final String route;
  final NavIdentifier identifier;
  final String icon;

  NavItem({
    required this.route,
    required this.identifier,
    required this.icon,
  });

  static List<NavItem> navItems = [home, learn, piggybank, profile];

  static NavItem home =
      NavItem(route: '/home', identifier: NavIdentifier.home, icon: "home");
  static NavItem learn = NavItem(
      route: '/record', identifier: NavIdentifier.record, icon: "record");
  static NavItem piggybank =
      NavItem(route: '/class', identifier: NavIdentifier.Class, icon: "class");
  static NavItem profile = NavItem(
      route: '/profile', identifier: NavIdentifier.profile, icon: "user");
}
