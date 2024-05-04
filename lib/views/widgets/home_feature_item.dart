import 'package:chat_armor/shared/theme.dart';
import 'package:flutter/material.dart';

class HomeFeatureItem extends StatelessWidget {

  final String iconUrl;
  final String title;

  const HomeFeatureItem({
    Key? key,
    required this.iconUrl,
    required this.title,
  }) :  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image.asset(
            iconUrl,
            width: 48,
          ),

          const SizedBox(
            width: 16,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
          ),

          // GANTI INI MENJADI TOMBOL ON OFF
          CrazySwitch(),
        ],
      ),
    );
  }
}

class CrazySwitch extends StatefulWidget {
  @override
  _CrazySwitchState createState() => _CrazySwitchState();
}

class _CrazySwitchState extends State<CrazySwitch> with SingleTickerProviderStateMixin{

  bool isChecked = false;
  Duration _duration = Duration(milliseconds: 370);
  late Animation<Alignment> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _duration
    );

    _animation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight
    ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.bounceOut,
          reverseCurve: Curves.bounceIn
        ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_animationController.isCompleted) {
            _animationController.reverse();
          } else {
            _animationController.forward();
          }

          isChecked = !isChecked;
        });
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            width: 70,
            height: 30,
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            decoration: BoxDecoration(
              color: isChecked ? greenColor : redColor,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: _animation.value,
                  child: Container(
                    width: 30,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: whiteColor,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: isChecked ? Alignment.centerLeft : Alignment.centerRight,
                    child: Padding(
                      padding: isChecked ? EdgeInsets.only(left: 8.0) : EdgeInsets.only(right: 8.0),
                      child: Text(
                        isChecked ? "ON" : "OFF",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}