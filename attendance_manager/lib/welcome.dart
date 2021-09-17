import 'package:attendance_manager/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:attendance_manager/auth/login.dart';
import 'package:attendance_manager/auth/signup.dart';
// import 'package:attendance_manager/Flutter-Neumorphic-master/Flutter-Neumorphic-master/lib/flutter_neumorphic.dart';

class SplashScreen6 extends StatefulWidget {
  @override
  _SplashScreen6State createState() => _SplashScreen6State();
}

class _SplashScreen6State extends State<SplashScreen6>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _scale2Controller;
  late AnimationController _widthController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _widthAnimation;
  late Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: LoginPage()));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeAnimation(
                  1,
                  Text(
                    "Welcome",
                    style: TextStyle(color: goldenColor, fontSize: 50),
                  )),
              SizedBox(
                height: 15,
              ),
              FadeAnimation(
                  1.3,
                  Text(
                    "We promise that you'll have the most \nfuss-free time with us ever.",
                    style: TextStyle(
                        color: Colors.white.withOpacity(.7),
                        height: 1.4,
                        fontSize: 20),
                  )),
              SizedBox(
                height: 380,
              ),
              FadeAnimation(
                  1.6,
                  AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _widthController,
                            builder: (context, child) {
                              print(_widthAnimation.value);
                              return Container(
                                width: _widthAnimation.value,
                                height: 80,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: _widthAnimation.value > 80
                                        ? Colors.white.withOpacity(0.4)
                                        : Colors.transparent),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    _scaleController.forward();
                                  },
                                  child: Stack(children: <Widget>[
                                    AnimatedBuilder(
                                      animation: _positionController,
                                      builder: (context, child) => Positioned(
                                        left: _positionAnimation.value,
                                        child: AnimatedBuilder(
                                          animation: _scale2Controller,
                                          builder: (context, child) =>
                                              Transform.scale(
                                                  scale: _scale2Animation.value,
                                                  child: Neumorphic(
                                                    style: NeumorphicStyle(
                                                        shape: NeumorphicShape
                                                            .concave,
                                                        boxShape:
                                                            NeumorphicBoxShape
                                                                .circle(),
                                                        depth: 2,
                                                        lightSource:
                                                            LightSource.topLeft,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      child: hideIcon == false
                                                          ? Icon(
                                                              Icons
                                                                  .arrow_forward,
                                                              color:
                                                                  goldenColor,
                                                            )
                                                          : Container(),
                                                    ),
                                                  )),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            },
                          ),
                        )),
                  )),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login Page"),
//       ),
//       backgroundColor: Colors.grey.withOpacity(0.3),
//       body: Container(
//         padding: EdgeInsets.all(30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FadeAnimation(
//                 1.2,
//                 Text(
//                   "Login",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 40,
//                       fontWeight: FontWeight.bold),
//                 )),
//             SizedBox(
//               height: 30,
//             ),
//             FadeAnimation(
//                 1.5,
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white),
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         decoration: BoxDecoration(
//                             border: Border(
//                                 bottom: BorderSide(color: Colors.grey[300]!))),
//                         child: TextField(
//                           decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintStyle:
//                                   TextStyle(color: Colors.grey.withOpacity(.8)),
//                               hintText: "Email or Phone number"),
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(),
//                         child: TextField(
//                           decoration: InputDecoration(
//                               border: InputBorder.none,
//                               hintStyle:
//                                   TextStyle(color: Colors.grey.withOpacity(.8)),
//                               hintText: "Password"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             SizedBox(
//               height: 40,
//             ),
//             FadeAnimation(
//                 1.8,
//                 Center(
//                   child: Container(
//                     width: 120,
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         color: Colors.blue[800]),
//                     child: Center(
//                         child: Text(
//                       "Login",
//                       style: TextStyle(color: Colors.white.withOpacity(.7)),
//                     )),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }

enum AnimationType { opacity, translateX }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationType>()
      ..add(
        AnimationType.opacity,
        Tween(begin: 0.0, end: 1.0),
        Duration(milliseconds: 500),
      )
      ..add(
        AnimationType.translateX,
        Tween(begin: 30.0, end: 1.0),
        Duration(milliseconds: 500),
      );

    return PlayAnimation<MultiTweenValues<AnimationType>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AnimationType.opacity),
        child: Transform.translate(
            offset: Offset(value.get(AnimationType.translateX), 0),
            child: child),
      ),
    );
  }
}
