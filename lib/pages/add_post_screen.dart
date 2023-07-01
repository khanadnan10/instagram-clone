// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/provider/provider.dart';
import 'package:instagram_clone/database/firestore_methods.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';

class AddPostscreen extends StatefulWidget {
  const AddPostscreen({super.key});

  @override
  State<AddPostscreen> createState() => _AddPostscreenState();
}

class _AddPostscreenState extends State<AddPostscreen> {
  Uint8List? _file;
  final TextEditingController _desController = TextEditingController();

  bool isLoading = false;

  void _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) {
          return SimpleDialog(
            title: const Text('Create Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20.0),
                onPressed: () async {
                  previousPage(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
                child: const Text('Take a photo'),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20.0),
                onPressed: () async {
                  previousPage(context);
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
                child: const Text('Choose from photos'),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20.0),
                onPressed: () async {
                  previousPage(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        });
  }

  void _postImage(
    String uid,
    String userName,
    String profImage,
  ) async {
    try {
      setState(() {
        isLoading = true;
      });
      String res = await FirestoreMethods().uploadPost(
        _desController.text,
        uid,
        _file!,
        userName,
        profImage,
      );

      if (res == 'success') {
        setState(() {
          isLoading = false;
          _file = null;
        });
        showSnackBar(context, 'Posted!');
      } else {
        setState(() {
          isLoading = false;
          _file = null;
        });
        showSnackBar(context, res);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    _desController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Scaffold(
            body: Center(
              child: IconButton(
                onPressed: () => _selectImage(context),
                icon: const Icon(
                  Icons.upload,
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  previousPage(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              title: const Text('Post to'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {
                    _postImage(
                      user.uid,
                      user.username,
                      user.photoUrl,
                    );
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                isLoading
                    ? const Center(
                        child: LinearProgressIndicator(),
                      )
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(
                  color: mobileBackgroundColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        controller: _desController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45.0,
                      width: 45.0,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
