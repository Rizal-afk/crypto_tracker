import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    //mengecek nilai imagePath mengandung blob:http
    final contains = imagePath.contains(RegExp('blob:http'), 0);

    if(contains ||
        imagePath=='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyoZspK0y6MPSyaxL229SGu7C23C8j-Nm0VQ&usqp=CAU')
    {
      final image = NetworkImage(imagePath);
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: image,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
            child: InkWell(onTap: onClicked),
          ),
        ),
      );
    } else {
      final image = File(imagePath);
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Image.file(
              image,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
            ) ,
              onTap: onClicked
          ),
        ),
      );
    }
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        isEdit ? Icons.add_a_photo : Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}