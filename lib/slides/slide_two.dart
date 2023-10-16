import 'package:flutter/material.dart';
import 'package:flutter_presentation/clippers/half_curve_clipper.dart';
import 'package:flutter_presentation/const/colors.dart';

class SlideTwo extends StatefulWidget {
  final Size size;
  const SlideTwo({super.key, required this.size});

  @override
  State<SlideTwo> createState() => _SlideTwoState();
}

class _SlideTwoState extends State<SlideTwo> with TickerProviderStateMixin {
  late AnimationController _logoPositionController;
  late AnimationController _onClickAnimationController;

  late Animation<double> _logoPositionAnim;
  late Animation<double> _clippersPositionAnim;

  @override
  void initState() {
    _logoPositionController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _onClickAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _logoPositionAnim = Tween<double>(begin: -100, end: 20).animate(
      CurvedAnimation(
          parent: _logoPositionController, curve: Curves.easeInOutBack),
    );

    _clippersPositionAnim =
        Tween<double>(begin: (widget.size.height / 2) + 25, end: 0.0).animate(
            CurvedAnimation(
                parent: _onClickAnimationController, curve: Curves.easeOut));

    _logoPositionController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: GestureDetector(
                onTap: () {
                  _onClickAnimationController.forward();
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: AnimatedBuilder(
                            animation: _clippersPositionAnim,
                            builder: (context, child) {
                              return ClipPath(
                                clipper: UpperHalfCurveClipper(),
                                child: Container(
                                  height: _clippersPositionAnim.value,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.blue[900],
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: -30,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                269,
                                        child: Text(
                                          "Flutter 101",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedBuilder(
                            animation: _clippersPositionAnim,
                            builder: (context, child) {
                              return ClipPath(
                                clipper: BottomHalfCurveClipper(),
                                clipBehavior: Clip.hardEdge,
                                child: Container(
                                  height: _clippersPositionAnim.value,
                                  width: MediaQuery.of(context).size.width,
                                  color: colors[1],
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: -50,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                269,
                                        child: Text(
                                          "Flutter 101",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                      Positioned(
                                        top: 125,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                170,
                                        child: Text(
                                          "With Riktam Santra",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w100),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      // Center(
                      //   child: Text(
                      //     "Flutter 101",
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .displayLarge!
                      //         .copyWith(color: Colors.blue),
                      //   ),
                      // ),
                      TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 275),
                          duration: Duration(milliseconds: 250),
                          builder: (context, value, child) {
                            return Positioned(
                              bottom: -100,
                              left: MediaQuery.of(context).size.width / 2 -
                                  value / 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                height: value,
                                width: value,
                              ),
                            );
                          }),
                      AnimatedBuilder(
                        animation: _logoPositionAnim,
                        child: Image.asset(
                          'media/gdsc_logo_vertical.png',
                          width: 250,
                        ),
                        builder: (context, child) {
                          return Positioned(
                            bottom: _logoPositionAnim.value,
                            left: (MediaQuery.of(context).size.width / 2) -
                                250 / 2,
                            child: child ?? Container(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
