import 'package:delivery/helpers/styles.dart';
import 'package:flutter/material.dart';


class DefaultDialog extends StatefulWidget {
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final child;
  final String code = 'Default Dialog';
  final Image? img;

  const DefaultDialog(
      {Key? key, required this.title, this.img, this.child}) : super(key: key);

  @override
  _DefaultDialogState createState() => _DefaultDialogState();
}

class _DefaultDialogState extends State<DefaultDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  TextEditingController emailController = TextEditingController();
  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: padding,
              top: avatarRadius + padding,
              right: padding,
              bottom: padding),
          margin: const EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(padding),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
          widget.child
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: avatarRadius,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(avatarRadius)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.img,
                )),
          ),
        ),
      ],
    );
  }
}
