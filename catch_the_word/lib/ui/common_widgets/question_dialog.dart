import 'package:flutter/material.dart';

class QuestionDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function()? onYes;
  final Function()? onNo;
  const QuestionDialog(
      {Key? key,
      required this.title,
      required this.description,
      this.onYes,
      this.onNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(children: [
        Text(title),
        Text(description),
        Row(
          children: [
            Button(
              title: "Yes",
              onTap: onYes,
            )
          ],
        ),
      ]),
    );
  }
}

class Button extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const Button({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(),
    );
  }
}
