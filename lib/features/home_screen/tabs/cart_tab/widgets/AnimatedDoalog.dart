import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedDialog extends StatefulWidget {
  final String itemName;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const AnimatedDialog({
    super.key,
    required this.itemName,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleCancel() {
    _controller.reverse().then((_) {
      widget.onCancel();
    });
  }

  void _handleConfirm() {
    _controller.reverse().then((_) {
      widget.onConfirm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon with animation
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value * 0.1,
                      child: child,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                      size: 48.sp,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Title
                Text(
                  'Remove Item?',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: "Poppins",
                  ),
                ),

                SizedBox(height: 12.h),

                // Message
                Text(
                  'Are you sure you want to remove this item from your cart?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    height: 1.4,
                    fontFamily: "Poppins",
                  ),
                ),

                SizedBox(height: 24.h),

                // Buttons
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 200),
                        tween: Tween<double>(begin: 0.9, end: 1.0),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: OutlinedButton(
                          onPressed: _handleCancel,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Delete Button
                    Expanded(
                      child: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 200),
                        tween: Tween<double>(begin: 0.9, end: 1.0),
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: ElevatedButton(
                          onPressed: _handleConfirm,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Remove',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}