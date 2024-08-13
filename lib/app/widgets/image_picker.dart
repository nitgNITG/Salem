// Import the image_picker plugin
import 'dart:io';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/modules/base/profile_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import '../core/data/models/logged_user.dart';
import '../utils/helper_funcs.dart';
import 'messages.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    required this.loggedUser, required this.edit,
  });

  final LoggedUser loggedUser;
  final bool edit;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _imageFile;

  // This is the image picker
  final _picker =Platform.isIOS? ImagePickerPlatform.instance:ImagePicker();

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          backgroundColor: HexColor('#45474B'),
          title:Center(child:  CircularProgressIndicator(color: Colors.white ) )
        );
      },
    );
  }
  // This method will show a dialog to let the user choose between gallery or camera
  Future<void> _showImageSourceDialog() async {
    // Create a list of selection items
    final items = [
      SelectionItem(
        text: 'المعرض',
        action: () {
          // Close the dialog and pick an image from the gallery
          Navigator.pop(context);
          _pickImage(ImageSource.gallery);
        },
      ),
      // SelectionItem(
      //   text: 'Camera',
      //   action: () {
      //     // Close the dialog and pick an image from the camera
      //     Navigator.pop(context);
      //     _pickImage(ImageSource.camera);
      //   },
      // ),
    ];

    // Show the dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: HexColor('#45474B'),
        titlePadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        title: Text(
          'اختر مصدر الصوره',
          style: TextStyle(color: HexColor('#F4CE14')),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.map((item) => _getOptionWidget(item)).toList(),
        ),
      ),
    );
  }

  // This method will pick an image from the given source
  Future<void> _pickImage(ImageSource source) async {
    var pickedImage = await ImagePickerPlatform.instance.pickImage(source: source);
    if (pickedImage != null) {
        _imageFile = File(pickedImage.path);
        print(_imageFile!.uri);
      if(mounted)  setState((){});
        _showDialog(context);
        await uploadImage();}
  }

  // This method will create a widget for each selection item
  Widget _getOptionWidget(SelectionItem item) {
    return SimpleDialogOption(
      onPressed: item.action,
      child:Container(
        alignment: Alignment.center,
        height: getScreenHeight(context)*0.03,
        width: getScreenWidth(context)*0.2,
        color: HexColor('#008170'),
        child:  Text(
        item.text,
        style: TextStyle(
          
          color: HexColor('#F4CE14'),
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }

  uploadImage() async {
    try {
      MultipartFile multipartFile =
      await MultipartFile.fromFile(_imageFile!.path);
      var data = FormData.fromMap({
        'image': multipartFile,
      });

      var dio = Dio();
      var response = await dio.request(
        'https://salem-mar3y.com/salem_apis/signleteacher/apis.php?function=upload_image&token=${widget
            .loggedUser.token}',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      print(response.data);
      if (response.statusCode == 200 && response.data['status'] == "success") {
      if(mounted) {
        Navigator.pop(context);
        showSnackBar(context, getL10(context).updatedSuccesfull,
            color: HexColor('#008170'));}
        await BaseProfileController().StudentDetail();
      } else {
       if(mounted) showSnackBar(context, getL10(context).tryAgain);
      }
    }catch(e){
      print(e.toString());
     if(mounted) showSnackBar(context, getL10(context).tryAgain);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: getScreenWidth(context)*0.35,height:getScreenHeight(context)*0.3 ,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: _imageFile == null
                ? DecorationImage(
                    image: NetworkImage(
                      widget.loggedUser.image,
                    ),
                    fit: BoxFit.fitHeight,
                  )
                : DecorationImage(
                    image: FileImage(
                      _imageFile!,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
          ),
        ),
        widget.edit?
        Positioned(
          bottom:getScreenHeight(context)* 0.08,
          right:getScreenWidth(context)* 0.14,
          // width: 70,
          // height: 20,
          child:ImageIcon(AssetImage('assets/images/Edit.png'),color:HexColor('#45474B')
    )
        ):  Text(''),
      ],
    ).onTap(_showImageSourceDialog);
  }
}

// This class represents a selection item for the image source dialog
class SelectionItem {
  final String text;
  final GestureTapCallback action;

  SelectionItem({required this.text, required this.action});
}
