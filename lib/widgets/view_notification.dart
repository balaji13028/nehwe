import 'package:flutter/material.dart';

class ViewNOtification extends StatefulWidget {
  String message = '';
  ViewNOtification({super.key, required this.message});

  @override
  State<ViewNOtification> createState() => _ViewNOtificationState();
}

class _ViewNOtificationState extends State<ViewNOtification> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null) {
      Map? pushargs = arguments as Map;

      setState(() {
        widget.message = pushargs['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('push message : ${widget.message}'),
        ),
      ),
    );
  }
}
