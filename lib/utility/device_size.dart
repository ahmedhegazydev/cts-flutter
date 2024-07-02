// import 'package:flutter/material.dart';
//
// class DeviceSize extends StatelessWidget {
//   final Widget? mobile;
//   final Widget? tablet;
//
//   const DeviceSize({
//    // required Key key,
//     required this.mobile,
//     required this.tablet,
//   });// : super(key: key);
//
//   static bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < 800;
//
//   static bool isTablet(BuildContext context) =>
//      MediaQuery.of(context).size.width < 1100 &&
//       MediaQuery.of(context).size.width >= 800;
//
//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     if (_size.width >= 850 && tablet != null) {
//       return tablet!;
//     } else {
//       return mobile!;
//     }
//   }
// }
import 'package:flutter/material.dart';

class DeviceSize{

  static  bool isMobile(BuildContext context) =>
  MediaQuery.of(context).size.width < 800;

  static    bool isTablet(BuildContext context) =>
  MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 800;
  static  bool isPortrait(BuildContext context) => MediaQuery.of(context).orientation==Orientation.portrait;
 // Orientation orientation =;
}