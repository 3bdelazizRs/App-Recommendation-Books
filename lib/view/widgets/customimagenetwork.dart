import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;

  const CustomNetworkImage({super.key, required this.url});

  Future<Uint8List> _fetchImage(String url) async {
    Dio dio = Dio();
    final response = await dio.get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
        },
      ),
    );

    if (response.statusCode == 200) {
      return Uint8List.fromList(response.data);
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _fetchImage(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return  Center(child:  Lottie.asset("assets/json/book_loading.json"));
        } else if (snapshot.hasError) {
          return const Icon(Icons.error);
        } else {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.fill,
          );
        }
      },
    );
  }
}
