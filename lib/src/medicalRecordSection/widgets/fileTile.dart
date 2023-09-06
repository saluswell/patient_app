import 'package:flutter/material.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import 'image_preview.dart';


class FileTile extends StatelessWidget {
  final dynamic path;
  final VoidCallback onTap;

  const FileTile({Key? key, required this.onTap, required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              InkWell(
                onTap: () {
                  toNext(
                      context: context,
                      widget: ImagePreview(
                        path: path,
                      ));
                },
                child: Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Image.file(
                    (path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  left: 48,
                  top: -18,
                  child: IconButton(
                    onPressed: onTap,
                    icon: const Icon(Icons.remove_circle),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
