import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import 'image_preview.dart';
import 'image_preview_network.dart';

class FileNetwokImageTile extends StatelessWidget {
  final dynamic path;
  final VoidCallback onTap;

  const FileNetwokImageTile({Key? key, required this.onTap, required this.path})
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
                      widget: ImagePreviewNetWork(
                        path: path,
                      ));
                },
                child: CachedNetworkImage(
                    height: 65,
                    width: 65,
                    imageBuilder: (context, imageProvider) => Container(
                          width: 65.0,
                          height: 65.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border:
                                Border.all(width: 1, color: AppColors.appcolor),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                    imageUrl: path,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => const SpinKitWave(
                            color: AppColors.appcolor,
                            size: 22,
                            type: SpinKitWaveType.start),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
