import 'package:flutter/material.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final int currentSelected;
  final Widget child;
  final void Function(int) onDestinationSelected;

  const MainScreen({
    super.key,
    required this.currentSelected,
    required this.child,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorStyle.primaryColor,
        shape: const CircleBorder(),
        child: Image.asset(
          'assets/image/add.png',
          width: 24,
          height: 24,
        ),
        onPressed: () {
          context.push('/create');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: ColorStyle.white,
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Image.asset(
                  currentSelected == 0
                      ? 'assets/image/nav_home_selected.png'
                      : 'assets/image/nav_home.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => onDestinationSelected(0),
              ),

              IconButton(
                icon: currentSelected == 1
                    ? const Icon(
                        Icons.message,
                        size: 24,
                      )
                    : const Icon(
                        Icons.message_outlined,
                        size: 24,
                      ),
                onPressed: () => onDestinationSelected(2),
              ),

              const SizedBox(width: 40), // 중앙 버튼 공간

              IconButton(
                icon: currentSelected == 2
                    ? const Icon(
                        Icons.not_interested,
                        size: 24,
                      )
                    : const Icon(
                        Icons.not_interested_outlined,
                        size: 24,
                      ),
                onPressed: () => onDestinationSelected(2),
              ),

              IconButton(
                icon: Image.asset(
                  currentSelected == 3
                      ? 'assets/image/nav_profile_selected.png'
                      : 'assets/image/nav_profile.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => onDestinationSelected(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
