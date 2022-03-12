import 'dart:io';
import '../../constants/Keys.dart';
import '../../constants/AppColors.dart';
import '../Navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Picker{

  static pickImage({   bool isMultiImage = false})async{



     return await showDialog(
        context: Keys.navigatorKey.currentContext,
        builder: (context) {
        return PickImageDialog();
        });

    // final ImagePicker _picker = ImagePicker();
    // // Pick an image
    // final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    // // Capture a photo
    // final XFile photo = await _picker.pickImage(source: ImageSource.camera);
    // // Pick a video
    // final XFile video = await _picker.pickVideo(source: ImageSource.gallery);
    // // Capture a video
    // final XFile videoCam = await _picker.pickVideo(source: ImageSource.camera);
    // // Pick multiple images
    // final List<XFile> images = await _picker.pickMultiImage();

  }

}
class PickImageDialog extends StatefulWidget {
  @override
  _PickImageDialogState createState() => _PickImageDialogState();
}

class _PickImageDialogState extends State<PickImageDialog> {
  XFile file;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      //  title: Text('Select source'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
             // color: Colors.white,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: <Widget>[
                  IconButton(onPressed: ()async{
                    file = await ImagePicker().pickImage(source: ImageSource.camera);
                    setState(() {

                    });
                  }, icon: Icon(Icons.linked_camera_sharp),


                  ),
                  IconButton(onPressed: ()async{
                    file =await ImagePicker().pickImage(source: ImageSource.gallery);
                    setState(() {

                    });
                  }, icon: Icon(Icons.photo_library))

                ],
              ),
            ),
          ),
          if( file != null)
            Image.file(File(file.path)),

          if( file != null)
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: <Widget>[
                ElevatedButton(
                    onPressed: (){
                      Navigation.pop(value: file);
                    },
                    child: Text('Done')
                ),

                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(AppColors.red) ) ,
                    onPressed: (){
                      Navigation.pop( );
                    },
                    child: Text('Cancel')
                ),

              ],
            ),
          ),
        ],
      ),

    );
  }
}
