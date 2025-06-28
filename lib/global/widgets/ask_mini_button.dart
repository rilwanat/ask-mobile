import 'package:flutter/material.dart';

import '../app_color.dart';

class AskMiniButton extends StatefulWidget {
  final String text;
  final VoidCallback function;
  final bool? enabled;
  final Color backgroundColor;
  final Color textColor;
  final double buttonWidth;
  final double buttonHeight;
  final int borderCurve;
  final bool? border;
  final String? imgPath;
  final IconData? icon;
  final Color? iconColor;
  final Color? borderColor;
  final double? textSize;

  const AskMiniButton({
    Key? key,
    required this.text,
    required this.function,
    required this.backgroundColor,
    required this.textColor,
    this.enabled,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.borderCurve,
    required this.border,
    this.imgPath,
    this.icon,
    this.iconColor,
    this.borderColor,
    this.textSize,
  }) : super(key: key);

  @override
  _FlashButtonState createState() => _FlashButtonState();
}

class _FlashButtonState extends State<AskMiniButton>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        lowerBound: 0.0,
        upperBound: 0.2)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - controller.value;

    void onTapDown(TapDownDetails details) {
      //controller.forward();
    }

    void onTapUp(TapUpDetails details) {
      //controller.reverse();
      if (widget.enabled != null) widget.function();
    }

    return Transform.scale(
      scale: scale,
      child: GestureDetector(
        onTapDown: (widget.enabled != null) ? null : onTapDown,
        onTapUp: onTapUp,
        onTapCancel: () {
          //controller.reverse();
        },
        child: Container(
            height: widget.buttonHeight,
            width: widget.buttonWidth,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(
                  double.parse(widget.borderCurve.toString())),
              // boxShadow: shadowDefault,
              border: widget.border!
                  ? Border.all(width: 1, color: widget.borderColor!)
                  : null,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // widget.imgPath == null
                    //     ? const SizedBox()
                    //     : SizedBox(
                    //   height: 24,
                    //   width: 24,
                    //   child: Image.asset(
                    //     widget.imgPath!,
                    //     fit: BoxFit.contain,
                    //     //size: 20,
                    //     //color: AppColors.white,
                    //   ),
                    // ),
                    // widget.icon == null
                    //     ? const SizedBox()
                    //     : SizedBox(
                    //   height: 20,
                    //   width: 20,
                    //   child: Icon(
                    //     widget.icon!,
                    //     size: 18,
                    //     color: widget.iconColor!,
                    //   ),
                    // ),
                    // widget.imgPath == null
                    //     ? const SizedBox()
                    //     : const SizedBox(
                    //   width: 8,
                    // ),
                    // widget.icon == null
                    //     ? const SizedBox()
                    //     : const SizedBox(
                    //   width: 8,
                    // ),
                    SizedBox(
                      width: 90, // Explicit width
                      height: 50,  // Explicit height
                      child: Center(
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: widget.textSize ?? 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: "LatoRegular",
                            color: widget.textColor,
                            // letterSpacing: .2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          //  ]),
        ),
      ),
    );
  }
}
