import 'package:flutter/material.dart';



// hiệu ứng chuyển trang qua trái qua phải
class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  CustomPageRoute({
    required this.child,
    this.direction = AxisDirection.right,
    super.settings
  })
      : super(
      transitionDuration: const Duration(milliseconds: 400),
      reverseTransitionDuration:  const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => child
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
          begin: getBeginOffset(),
          end: Offset.zero
      ).animate(animation),
      child: child,
    );
  }
  Offset getBeginOffset() {
    // debugPrint(direction.toString());
    switch (direction){
      case AxisDirection.up:
        return const Offset(0, 1);
      case AxisDirection.down:
        return const Offset(0, -1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
    }
  }
}
