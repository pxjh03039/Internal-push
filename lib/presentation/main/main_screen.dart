import 'package:flutter/material.dart';
import 'package:push_test_app/core/di/di_setup.dart';
import 'package:push_test_app/presentation/message/message_view_model.dart';
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
                icon: currentSelected == 0
                    ? const Icon(
                        Icons.home,
                        size: 30,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        size: 30,
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
                onPressed: () {
                  final messageViewModel = getIt<MessageViewModel>();
                  messageViewModel.initData();
                  onDestinationSelected(1);
                },
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
                onPressed: null,
              ),

              IconButton(
                icon: currentSelected == 3
                    ? const Icon(
                        Icons.person,
                        size: 30,
                      )
                    : const Icon(
                        Icons.person_outline,
                        size: 30,
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
