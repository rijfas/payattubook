import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants/assets.dart';

class AvatarImagePicker extends StatefulWidget {
  const AvatarImagePicker({
    Key? key,
    required this.radius,
    required this.onProfileChanged,
    required this.onProfileDeleted,
    this.profileUrl = '',
  }) : super(key: key);
  final double radius;
  final String profileUrl;
  final void Function(Uint8List? image, String fileName) onProfileChanged;
  final void Function() onProfileDeleted;
  @override
  State<AvatarImagePicker> createState() => _AvatarImagePickerState();
}

class _AvatarImagePickerState extends State<AvatarImagePicker> {
  @override
  void initState() {
    super.initState();
    if (widget.profileUrl != '') {
      _image = CachedNetworkImageProvider(widget.profileUrl);
    }
  }

  ImageProvider? _image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: widget.radius,
            foregroundImage: _image,
            backgroundImage: const AssetImage(Assets.defaultProfile),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: (_image == null)
                ? IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final imageFile = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 25,
                      );
                      final fileExt = imageFile?.path.split('.').last;
                      final fileName =
                          '${DateTime.now().toIso8601String()}.$fileExt';
                      if (imageFile == null) {
                        return;
                      }
                      final image = await imageFile.readAsBytes();
                      setState(() {
                        _image = MemoryImage(image);
                      });

                      widget.onProfileChanged(image, fileName);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _image = null;
                      });
                      widget.onProfileDeleted();
                    },
                  ))
      ],
    );
  }
}
