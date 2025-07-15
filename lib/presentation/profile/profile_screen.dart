import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_test_app/presentation/profile/profile_view_model.dart';
import 'package:push_test_app/ui/color_style.dart';
import 'package:push_test_app/ui/text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    return Scaffold(
      body: SafeArea(
          child: Align(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Profile',
              style: TextStyles.mediumTextBold,
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 99,
                    height: 99,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/image/profile_sample.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Column(
                    children: [
                      const Text(
                        '\${uuid}',
                        style: TextStyles.normalTextBold,
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Text(
                        'data2',
                        style: TextStyles.smallerTextRegular
                            .copyWith(color: ColorStyle.gray3),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: viewModel.getuserInfo,
                          child: const Text('Edit'))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
