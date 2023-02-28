import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// void navigateTo(Widget screen, BuildContext context) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => screen))
//       .then((value) => Navigator.pop(context));
// }
//
// void navigateTo2(Widget screen, BuildContext context, bool closeAppAtBackButton) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => screen))
//       .then((value) {
//     if (closeAppAtBackButton && !Navigator.canPop(context)) {
//       SystemNavigator.pop();
//     }
//   });
// }

void navigateTo(Widget screen, BuildContext context, bool closeAppAtBackButton) {
  if (closeAppAtBackButton) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    ).then((_) => SystemNavigator.pop());
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

Center loadingSmall() => const Center(
  child: CircularProgressIndicator(),
);

Center errorLoadText(String message) => Center(
  child: Text('Error: $message'),
);
