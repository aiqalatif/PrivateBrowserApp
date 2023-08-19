import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:privatebrowser/View/hy.dart';

class SingleDownloadScreen extends StatefulWidget {
  const SingleDownloadScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleDownloadScreen> createState() => _SingleDownloadScreenState();
}

class _SingleDownloadScreenState extends State<SingleDownloadScreen> {
  TextEditingController url = TextEditingController();
  double? _progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  SecondScreen(initialurl: '',)),
          );
        },),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            const Text(
              'Download Any File From URL',
              style: TextStyle(
                fontSize: 20,
              ),

              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(width: 2,color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: TextField(
                controller: url,

              ),
            ),
            const SizedBox(height: 16),
            _progress != null
                ? const CircularProgressIndicator()
                : ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black, //button's fill color
                onPrimary: Colors.white, //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                 //specify the button's disabled text, icon, and fill color
                shadowColor: Colors.black, //specify the button's elevation color
                elevation: 4.0, //button

              ),

                onPressed: () {
                  FileDownloader.downloadFile(
                      url: url.text.trim(),
                      onProgress: (name, progress) {
                        setState(() {
                          _progress = progress;
                        });
                      },
                      onDownloadCompleted: (value) {
                        print('path  $value ');
                        setState(() {
                          _progress = null;
                        });
                      });
                },
                child: const Text('Download')),
          ],
        ),
      ),
    );
  }
}
