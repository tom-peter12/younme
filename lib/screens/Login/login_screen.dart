import 'package:flutter/material.dart';
// import 'package:flutter_auth/responsive.dart';

import '../../background.dart';
import '../../responsive.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileLoginScreen(),
          // desktop: Row(
          //   children: [
          //     const Expanded(
          //       child: LoginScreenTopImage(),
          //     ),
          //     Expanded(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: const [
          //           SizedBox(
          //             width: 450,
          //             child: LoginForm(),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
