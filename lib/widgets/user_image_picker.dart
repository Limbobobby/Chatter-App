import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class InputImageWidget extends StatefulWidget {
  InputImageWidget(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _InputImageWidgetState createState() => _InputImageWidgetState();
}

class _InputImageWidgetState extends State<InputImageWidget> {
  File _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    PickedFile image = await picker.getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    setState(() {
      _pickedImage = File(image.path);
    });
    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
        backgroundColor: Colors.grey,
        radius: 40,
      ),
      FlatButton.icon(
        onPressed: _pickImage,
        label: Text('add Picture'),
        textColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.image),
      )
    ]);
  }
}
