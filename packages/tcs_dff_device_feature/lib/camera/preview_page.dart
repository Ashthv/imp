import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import '../utils/crop_image.dart';

class PreviewPage extends StatefulWidget {
  final XFile picture;
  final int direction;

  const PreviewPage({
    super.key,
    required this.picture,
    required this.direction,
  });

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late final File finalImage;

  Future<File> mirrorFrontCamera(final BuildContext context) async {
    if (widget.direction == 1) {
      final capturedImage =
          img.decodeImage(await File(widget.picture.path).readAsBytes());
      final orientedImage = img.flipHorizontal(capturedImage!);
      finalImage = await File(widget.picture.path)
          .writeAsBytes(img.encodeJpg(orientedImage));
    }
    return finalImage;
  }

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          children: [
            FutureBuilder<File>(
              future: mirrorFrontCamera(context),
              builder: (
                final BuildContext context,
                final AsyncSnapshot<File> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: buildFlippedImage(widget.direction, context),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context, [null]);
                  },
                  child: const Icon(Icons.restart_alt_outlined),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (context.mounted) {
                      widget.direction == 1
                          ? Navigator.pop(context, [File(finalImage.path)])
                          : Navigator.pop(context, [File(widget.picture.path)]);
                    }
                  },
                  child: const Icon(Icons.done),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final croppedImage = widget.direction == 1
                        ? await cropImage(
                            picture: File(finalImage.path),
                          )
                        : await cropImage(
                            picture: File(widget.picture.path),
                          );
                    if (croppedImage != null) {
                      if (context.mounted) {
                        Navigator.pop(context, [croppedImage]);
                      }
                    }
                  },
                  child: const Icon(Icons.crop_outlined),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildFlippedImage(
    final int direction,
    final BuildContext context,
  ) {
    if (direction == 1) {
      return Image.file(
        File(finalImage.path),
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.78,
      );
    } else {
      return Image.file(
        File(widget.picture.path),
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.8,
      );
    }
  }
}
