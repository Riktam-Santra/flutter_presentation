import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_presentation/providers/slide_index_provider.dart';
import 'package:flutter_presentation/slides/slide_two.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../const/colors.dart';
import '../painters/background_painter.dart';

class SlideOne extends StatefulWidget {
  final Size size;
  const SlideOne({super.key, required this.size});

  @override
  State<SlideOne> createState() => _SlideOneState();
}

class _SlideOneState extends State<SlideOne> with TickerProviderStateMixin {
  bool circleDone = false;
  bool hasClicked = false;

  late List<Circle> circles;
  late AnimationController _opacityAnimController;
  late AnimationController _transitionAnimController;
  late Animation _opacityAnimation;
  late Animation<double> _circleSizeAnimation;

  @override
  void initState() {
    super.initState();
    _opacityAnimController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _opacityAnimController, curve: Curves.easeIn));

    _transitionAnimController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _circleSizeAnimation = Tween<double>(begin: 800, end: 2000).animate(
      CurvedAnimation(parent: _transitionAnimController, curve: Curves.easeOut),
    );

    circles = _generateRandomCircles(const Size(2000, 2000));

    _opacityAnimController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
          body: GestureDetector(
        onTap: () {
          _opacityAnimController.reverse();
          setState(() {
            hasClicked = true;
            _transitionAnimController.forward().whenComplete(
                () => ref.read(slideIndexProvider.notifier).increment());
          });
        },
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            CustomPaint(
              painter: BackgroundPainter(circles: circles),
              size: MediaQuery.of(context).size,
            ),
            circleDone
                ? Center(
                    child: AnimatedBuilder(
                      animation: _circleSizeAnimation,
                      builder: (context, child) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width -
                                      _circleSizeAnimation.value)),
                          height: _circleSizeAnimation.value,
                          width: _circleSizeAnimation.value,
                        );
                      },
                    ),
                  )
                : Center(
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 800),
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 1000),
                      onEnd: () => setState(() {
                        circleDone = true;
                      }),
                      builder: (context, value, child) {
                        return Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          height: value,
                          width: value,
                        );
                      },
                    ),
                  ),
            AnimatedBuilder(
              animation: _opacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimController.value,
                  child: Center(
                    child: SizedBox(
                      height: 250,
                      child: Image.asset(
                        "media/gdsc_logo_vertical.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ));
    });
  }

  List<Circle> _generateRandomCircles(Size size) {
    Random random = Random();
    List<Circle> circles = [];

    for (double i = 0; i < (size.width); i += 75) {
      for (double j = 0; j < (size.width); j += 75) {
        final paint = Paint()
          ..color = colors[random.nextInt(4)]
          ..style = PaintingStyle.fill;

        circles.add(
          Circle(
              offset: Offset(
                  i + random.nextDouble() * 50, j + random.nextDouble() * 50),
              radius: random.nextDouble() * (50 - 5) +
                  5, //source.nextDouble() * (end - start) + start;
              paint: paint),
        );
      }
    }
    return circles;
  }
}

class Circle {
  final Offset offset;
  final double radius;
  final Paint paint;

  Circle({required this.offset, required this.radius, required this.paint});
}
