import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class WebIcon extends StatefulWidget {
  final String url;

  WebIcon({required this.url});

  @override
  _WebIconState createState() => _WebIconState();
}

class _WebIconState extends State<WebIcon> {
  late Widget imgWidget;
  late bool loaded;

  @override
  void initState() {
    imgWidget = SizedBox.shrink();
    loaded = false;
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    Uri? uri = Uri.tryParse(widget.url);
    if (uri == null) {
      log("Invalid URL: ${widget.url}");
      return;
    }
    try {
      final response = await http.get(uri);
      log("reponse is ${response.statusCode}");
      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          response.headers["content-type"] != null &&
          response.headers["content-type"]!.contains("image")) {
        setState(() {
          imgWidget = Image.memory(response.bodyBytes);
          loaded = true;
        });
      } else {
        log("Failed to load image: ${widget.url}");
      }
    } catch (e) {
      log("Error loading image: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return imgWidget;
  }
}
