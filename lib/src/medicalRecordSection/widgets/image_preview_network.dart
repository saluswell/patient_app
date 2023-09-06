import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreviewNetWork extends StatelessWidget {
  final String path;
  const ImagePreviewNetWork({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(path),
            ),
            Positioned(
                child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.maybePop(context);
                        },
                        icon: Icon(Icons.close))))
          ],
        ),
      ),
    );
  }
}
