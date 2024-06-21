import 'package:flutter/material.dart';


class RouterHelper {
  static const initial = "/";
  static const taskListScreen = "/taskListScreen";
  static const addNewTaskScreen = "/addNewTaskScreen";
  static const taskDetailScreen = "/taskDetailScreen";
  static const homeScreen = "/homeScreen";
  static const paymentDetailScreen = "/paymentDetailScreen";
  static const showDetailScreen = "/showDetailScreen";

  static Map<String, Widget Function(BuildContext context)> routes = {
    // initial: (context) => const CustomerDetailScreen(),
    // paymentDetailScreen: (context) => const PaymentDetailScreen(),
    // showDetailScreen: (context) => const ShowDetailScreen(),
  };
}
