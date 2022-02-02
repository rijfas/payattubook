import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/constants/assets.dart';

class AvatarImagePicker extends StatefulWidget {
  const AvatarImagePicker({
    Key? key,
    required this.radius,
    required this.onProfileChanged,
    this.profileUrl = '',
  }) : super(key: key);
  final double radius;
  final String profileUrl;
  final void Function(Uint8List? image, String fileName) onProfileChanged;
  @override
  State<AvatarImagePicker> createState() => _AvatarImagePickerState();
}

class _AvatarImagePickerState extends State<AvatarImagePicker> {
  ImageProvider? _profile;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: widget.radius,
            foregroundImage: _profile ??
                (widget.profileUrl == ''
                    ? null
                    : NetworkImage(widget.profileUrl)),
            backgroundImage: const AssetImage(Assets.defaultProfile),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: (_profile == null)
                ? IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final imageFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      final fileExt = imageFile?.path.split('.').last;
                      final fileName =
                          '${DateTime.now().toIso8601String()}.$fileExt';
                      if (imageFile == null) {
                        return;
                      }
                      final image = await imageFile.readAsBytes();
                      setState(() {
                        _profile = MemoryImage(image);
                      });
                      widget.onProfileChanged(image, fileName);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _profile = null;
                        widget.onProfileChanged(null, '');
                      });
                    },
                  ))
      ],
    );
  }
}
