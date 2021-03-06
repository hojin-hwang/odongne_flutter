import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class NewEventEditDialog extends StatefulWidget {
  NewEventEditDialog() : super();

  final String title = "Upload Image Demo";

  @override
  NewEventEditDialogState createState() => NewEventEditDialogState();
}

class NewEventEditDialogState extends State<NewEventEditDialog> {
  final _formKey = GlobalKey<FormState>();
  static final String uploadEventUrl =
      'https://www.keepuble.com/keepuble/temp/command-add-test.php';

  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 400,
        );
      }),
    );
  }

  Future<void> chooseImage() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 4,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  uploadImageToServer() async {
    FormData formData = FormData();

    List<MultipartFile> imageList = [];
    String url = "https://www.keepuble.com/keepuble/temp/command-add-test.php";
    for (Asset asset in images) {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = new MultipartFile.fromBytes(
        imageData,
        filename: 'new_event_image',
        contentType: MediaType("image", "jpg"),
      );
      imageList.add(multipartFile);
    }

    print("Number of pictures:${imageList.length}");

    formData = FormData.fromMap({
      "files": imageList,
      "test": "${imageList.length}",
      'names': ['name1', 'name2', 'name3']
    });

    var formData2 = FormData.fromMap({
      'name': 'wendux',
      'age': 25,
      'files': [
        await MultipartFile.fromFile('./main.dart', filename: 'text1.txt'),
        await MultipartFile.fromFile('./menu.dart', filename: 'text2.txt'),
      ]
    });

    Map<String, dynamic> params = Map();

    Dio dio = new Dio();
    var response =
        await dio.post(url, data: formData2, queryParameters: params);

    print(response);
    //Response processing
    /*if (response.data["success"]) {
      print(response.data);
      Fluttertoast.showToast(
        msg: "The blog is uploaded successfully, waiting for review",
        gravity: ToastGravity.CENTER,
        textColor: Colors.grey,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Blog upload failed, please try again later",
        gravity: ToastGravity.CENTER,
        textColor: Colors.grey,
      );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                // Respond to button press
              },
              child: Text("????????????"),
              style: TextButton.styleFrom(
                primary: Colors.white,
              )),
        ],
        backgroundColor: Color(0xFF6200EE),
        title: Text('????????? ?????????'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // TextFormField(
            //   decoration: InputDecoration(
            //     errorText: "????????? ????????? ?????????.",
            //     contentPadding: const EdgeInsets.all(0.0),
            //     icon: Icon(Icons.euro_symbol_outlined),
            //     labelText: '????????? ??????',
            //     labelStyle: TextStyle(
            //       color: Color(0xFF6200EE),
            //     ),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: Color(0xFF6200EE)),
            //     ),
            //   ),
            //   onChanged: (value) {},
            // ),
            Text(
              'status',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),

            FloatingActionButton(
              onPressed: chooseImage,
              child: Icon(Icons.add),
            ),
            TextButton(
              onPressed: uploadImageToServer,
              child: Text("Send Token"),
            ),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
    );
  }
}
