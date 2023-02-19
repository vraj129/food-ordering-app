import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ordering_app/ui/widgets/custom_flat_button.dart';
import 'package:food_ordering_app/ui/widgets/custom_outline_button.dart';
import 'package:food_ordering_app/ui/widgets/custom_text_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 110,
              ),
              child: _buildLogo(),
            ),
            const SizedBox(
              height: 50,
            ),
            _buildUI()
          ],
        ),
      ),
    );
  }

  _buildLogo() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/logo.svg',
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
                text: "Food",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: "Space",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  _buildUI() {
    return Expanded(
      child: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _signIn(),
          _signUp(),
        ],
      ),
    );
  }

  _signIn() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ..._emailAndPassword(),
            const SizedBox(
              height: 30,
            ),
            CustomFlatButton(
              onPressed: () {},
              text: "Sign In",
            ),
            const SizedBox(
              height: 30,
            ),
            CustomOutlineButton(
              onPressed: () {},
              size: const Size(double.infinity, 54),
              icon: SvgPicture.asset(
                'assets/google-icon.svg',
                height: 18,
                width: 18,
              ),
              text: "Sign in with Google",
            ),
            const SizedBox(
              height: 30,
            ),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account?',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                children: [
                  TextSpan(
                    text: ' Sign up',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 1000), curve: Curves.elasticOut);
                      },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _signUp() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            CustomTextField(
              hint: 'Username',
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              onChanged: (val) {},
            ),
            const SizedBox(height: 30.0),
            ..._emailAndPassword(),
            const SizedBox(height: 30.0),
            CustomFlatButton(
              text: 'Sign up',
              onPressed: () {},
            ),
            const SizedBox(height: 30.0),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'Already have an account?',
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                children: [
                  TextSpan(
                    text: ' Sign in',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _controller.previousPage(
                            duration: const Duration(milliseconds: 1000), curve: Curves.elasticOut);
                      },
                  )
                ],
              ),
            )
          ],
        ),
      );
}

List<Widget> _emailAndPassword() {
  return [
    CustomTextField(
      hint: "Email",
      fontSize: 18,
      fontWeight: FontWeight.normal,
      onChanged: (val) {},
    ),
    const SizedBox(
      height: 30,
    ),
    CustomTextField(
      hint: "Password",
      fontSize: 18,
      fontWeight: FontWeight.normal,
      onChanged: (val) {},
    ),
  ];
}
