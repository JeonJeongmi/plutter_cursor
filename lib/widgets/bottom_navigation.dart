import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'asset/icon/hom.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              currentIndex == 0 
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor!
                : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
              BlendMode.srcIn
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'asset/icon/search.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              currentIndex == 1 
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor!
                : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
              BlendMode.srcIn
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'asset/icon/add.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor!
                : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
              BlendMode.srcIn
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'asset/icon/like.svg',
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              currentIndex == 3 
                ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor!
                : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
              BlendMode.srcIn
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'asset/icon/Oval.svg',
            width: 24,
            height: 24,
          ),
          label: '',
        ),
      ],
    );
  }
} 