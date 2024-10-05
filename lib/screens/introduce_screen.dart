import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tex/screens/home_screen.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreen();
}

class _IntroductionScreen extends State<IntroductionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? profileAvatarCurrentImage;
  
  var getImageSource = (BuildContext context) {
    return showDialog<ImageSource>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              child: const Text("Camera"),
              onPressed: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
                child: const Text("Gallery"),
                onPressed: () {
                  Navigator.of(context).pop(ImageSource.gallery);
                }),
          ],
        );
      },
    ).then((value) {
      return value ?? ImageSource.gallery;
    });
  };

  var getPrefferedCameraDevice = (BuildContext context) async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Allow Camera Permission"),
        ),
      );
      return null;
    }
    return showDialog<CameraDevice>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              child: const Text("Rear"),
              onPressed: () {
                Navigator.of(context).pop(CameraDevice.rear);
              },
            ),
            SimpleDialogOption(
                child: const Text("Front"),
                onPressed: () {
                  Navigator.of(context).pop(CameraDevice.front);
                }),
          ],
        );
      },
    ).then(
      (value) {
        return value ?? CameraDevice.rear;
      },
    );
  };

  String? firstName;
  String? lastName;
  int? age;
  String? bio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Center(
                    child: Text("Introduce yourself",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 80),
                  ProfileAvatar(
                    image: profileAvatarCurrentImage,
                    radius: 50,
                    allowEdit: true,
                    addImageIcon: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.add_a_photo),
                      ),
                    ),
                    removeImageIcon: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.close),
                      ),
                    ),
                    onImageChanged: (XFile? image) {
                      setState(() {
                        profileAvatarCurrentImage = image;
                      });
                    },
                    onImageRemoved: () {
                      setState(() {
                        profileAvatarCurrentImage = null;
                      });
                    },
                    getImageSource: () async => await getImageSource(context),
                    getPreferredCameraDevice: () async =>
                        await getPrefferedCameraDevice(context),
                  ),
                  const SizedBox(height: 80),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter your first name',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                firstName = value.toString();
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter your last name',
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                lastName = value.toString();
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Enter your age',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your age';
                                }
                                if (int.tryParse(value.toString()) == null) {
                                  return 'Please enter a valid age';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                age = int.parse(value.toString());
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'About you',
                              ),
                              textInputAction: TextInputAction.newline,
                              minLines: 1,
                              maxLines: 3,
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                bio = value.toString();
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  // Validate will return true if the form is valid, or false if
                                  // the form is invalid.
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState?.save();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                    );
                                  }
                                },
                                child: const Text('Next'),
                              ),
                            ),
                          ],
                        ),
                      ))
                ])));
  }
}
