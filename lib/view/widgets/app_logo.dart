import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/icon.png",
          height: 45,
          width: 45,
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SNTR",
              style: TextStyle(
                fontFamily: "Great_vibes",
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
              textHeightBehavior: TextHeightBehavior(
                applyHeightToFirstAscent: true,
                applyHeightToLastDescent: false,
              ),
            ),
            Row(
              children: [
                SizedBox(width: 5),
                Text(
                  "Mobile Banking",
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.teal),
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
