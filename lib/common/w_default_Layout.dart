import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final bool loginState;
  final Widget child;
  final String? title;
  final bool? bottomState;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;

  const DefaultLayout({
    super.key,
    required this.loginState,
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomState,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppbar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppbar() {
    if (title == null) {
      return null;
    } else {
      if (loginState == false) {
        return AppBar(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: null,
              icon: Image.asset('assets/images/usw_logo.png'),
            ).pOnly(left: 20),
            const Expanded(child: SizedBox()),
          ],
        );
      } else {
        return AppBar(
          backgroundColor: Colors.grey.shade300,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            Image.asset(
              'assets/images/usw_logo.png',
              height: 45,
              width: 45,
            ).pOnly(left: 20),
            const Expanded(child: SizedBox()),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
            ).pOnly(right: 20),
          ],
        );
      }
    }
  }
}