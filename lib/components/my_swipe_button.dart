
import 'package:e_learning/constant/palette.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';


class MySwipeButton extends StatefulWidget {
  final String? title;
  final Widget? icon;
  final bool? enabled;

  final Duration? duration;
  final double? height;
  final double? width;
  final double? buttonRadius;
  final BorderRadius? thumbRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final GestureTapCallback onSubmit;
  final GestureTapCallback? onSwipeStart;

  const MySwipeButton(
      {super.key,
        this.title,
        this.icon,
        required this.onSubmit,
        this.textStyle,
        this.backgroundColor,
        this.height,
        this.width,
        this.buttonRadius,
        this.thumbRadius,
        this.enabled,
        this.onSwipeStart,
        this.duration});

  @override
  State<MySwipeButton> createState() => _MySwipeButtonState();
}

class _MySwipeButtonState extends State<MySwipeButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          color: widget.enabled == true || widget.enabled == null
              ? (widget.backgroundColor ?? AppColors.black)
              : Colors.grey,
          borderRadius: BorderRadius.circular(widget.buttonRadius ?? 40.r)),
      child: SwipeButton(
        trackPadding:  EdgeInsets.all(10.w),
        inactiveTrackColor: Colors.grey,
        width: widget.width ?? 184.w,
        height: widget.height ?? 63.w,
        elevationThumb: 0,
        activeTrackColor: widget.backgroundColor ?? AppColors.white,
        activeThumbColor: AppColors.themeColor,
        thumbPadding: const EdgeInsets.all(2),
        borderRadius: widget.thumbRadius,
        enabled: widget.enabled ?? true,
        duration: widget.duration ?? const Duration(milliseconds: 500),
        thumb: widget.icon ??
            const Icon(
              Icons.arrow_forward,
              color: AppColors.white,
            ),
        onSwipe: widget.onSubmit,
        onSwipeEnd: () {

        },

        onSwipeStart: widget.onSwipeStart,
        child: Row(
          children: [
            SizedBox(width: ScreenUtil.defaultSize.width*.14,),
            Text(
              widget.title ?? "Swipe to ...",
              style: widget.textStyle ,
            ),

          ],
        ),
      ),
    );
  }
}

enum ButtonType {
  swipeButton,
  defaultButton,
}


