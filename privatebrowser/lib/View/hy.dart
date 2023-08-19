import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:privatebrowser/View/Assets.dart';
import 'package:privatebrowser/View/DarkThemScreen.dart';
import 'package:privatebrowser/View/checkpremission.dart';
import 'package:privatebrowser/View/test.dart';
import 'package:share_plus/share_plus.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // Create a TextEditingController to get the value of the textfield
  final textController = TextEditingController();
  final GlobalKey webViewKey = GlobalKey();
  final List<ContentBlocker> contentBlockers = [];
  var contentBlockerEnabled = true;
  bool isPermission = false;
  var checkAllPermissions = CheckPermission();
  // list of Ad URL filters to be used to block ads loading.
  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }
  final adUrlFilters = [
    ".*.doubleclick.net/.*",
    ".*.ads.pubmatic.com/.*",
    ".*.googlesyndication.com/.*",
    ".*.google-analytics.com/.*",
    ".*.adservice.google.*/.*",
    ".*.adbrite.com/.*",
    ".*.exponential.com/.*",
    ".*.quantserve.com/.*",
    ".*.scorecardresearch.com/.*",
    ".*.zedo.com/.*",
    ".*.adsafeprotected.com/.*",
    ".*.teads.tv/.*",
    ".*.outbrain.com/.*"
  ];
  PullToRefreshController?refreshController;
  InAppWebViewController?webViewController;
  late var url;
  var  initialurl='https://www.google.com/';
  var urlController=TextEditingController();
  var progress=0;
  var isloading=false;
  bool _isFullScreen = false;
  double ?_progress;
  @override
  void initState(){
    super.initState();

    for (final adUrlFilter in adUrlFilters) {
      contentBlockers.add(ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: adUrlFilter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }

    // apply the "display: none" style to some HTML elements
    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".banner, .banners, .ads, .ad, .advert")));
    refreshController=PullToRefreshController(
        options:PullToRefreshOptions(
            color: Colors.green,
            backgroundColor: Colors.white

        )

    );
  }

  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 50,right: 50,top: 100),
            height: 150,
            width: 150,
            child: Image.asset(ImageAssets.R),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Text('Welcome to Private Browser app',textAlign: TextAlign.center,
                style:TextStyle(color: Colors.black,fontSize: 20,fontStyle: FontStyle.italic)),
          ),
          SizedBox(height: 320,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            height: 50,
            width: 200,
            child: ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>   SecondScreen(initialurl: '',)),
                  );
                }, child: Text('Let Start',style:TextStyle(color: Colors.white,fontSize: 20,)),
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black
              ),
            ),
          ),
        ],
      ),
    );
  }
  void toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    }
    );

  }
}

class SecondScreen extends StatefulWidget {
  // The url passed from the first screen
  final String initialurl;

  const SecondScreen({Key? key,  required this.initialurl}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  InAppWebViewController?webViewController;

  PullToRefreshController?refreshController;
  final GlobalKey webViewKey = GlobalKey();
  final List<ContentBlocker> contentBlockers = [];
  var contentBlockerEnabled = true;
  bool isPermission = false;
  var checkAllPermissions = CheckPermission();
  // list of Ad URL filters to be used to block ads loading.
  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

  final adUrlFilters = [
    ".*.doubleclick.net/.*",
    ".*.ads.pubmatic.com/.*",
    ".*.googlesyndication.com/.*",
    ".*.google-analytics.com/.*",
    ".*.adservice.google.*/.*",
    ".*.adbrite.com/.*",
    ".*.exponential.com/.*",
    ".*.quantserve.com/.*",
    ".*.scorecardresearch.com/.*",
    ".*.zedo.com/.*",
    ".*.adsafeprotected.com/.*",
    ".*.teads.tv/.*",
    ".*.outbrain.com/.*"
  ];




  late var url;
  var  initialurl='https://www.google.com/';
  var urlController=TextEditingController();
  var progress=0;
  var isloading=false;
  bool _isFullScreen = false;
  double ?_progress;

  @override
  void initState(){
    super.initState();

    for (final adUrlFilter in adUrlFilters) {
      contentBlockers.add(ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: adUrlFilter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }

    // apply the "display: none" style to some HTML elements
    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".banner, .banners, .ads, .ad, .advert")));
    refreshController=PullToRefreshController(
        options:PullToRefreshOptions(
            color: Colors.green,
            backgroundColor: Colors.white

        )

    );
  }
  void _toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }
  bool isBookmarked = false;

  Future<void> _downloadFile(String url, String filename) async {
    // ... existing download code ...
  }
  List<String> menuItems = ['Home', 'Settings', 'About'];
  void _shareText() {
    String textToShare = urlController.text;
    if (textToShare.isNotEmpty) {
      Share.share(textToShare);
    } else {
      // Handle case when the TextField is empty
      print('Please enter some text to share.');
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 8,),
              Container(
                height: 60,
                width: 20,
                child: IconButton(onPressed: () async{
                  if(await webViewController!.canGoBack()){
                    webViewController!.goBack();
                  }
                  else{
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) =>  FirstScreen ()));
                  }
                },icon: Icon(Icons.arrow_back_ios ,color: Colors.grey,),),
              ),
              SizedBox(width: 8,),
              SizedBox(
                height: 60,
                width: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.grey,),
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    if (await webViewController!.canGoForward()) {
                      await webViewController!.goForward();
                    }


                  },
                ),
              ),
            ],
          ),
        ),
        title: Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black26)
          ),
          child: TextField(
            style: TextStyle(color: Colors.black, ),
            onSubmitted: (value){
              url=Uri.parse(value);
              if(url.scheme.isEmpty){
                url=Uri.parse("${initialurl}search?q=$value");
              }
              webViewController!.loadUrl(urlRequest: URLRequest(url: url));
            },
            controller: urlController,
            decoration:InputDecoration(
                hintText: 'Browser',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none
            ),

          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'download') {
                _downloadFile('https://www.example.com/sample.pdf', 'sample.pdf');
              } else if (value == 'bookmark') {
                _toggleBookmark();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: ' Share Url',
                  child: GestureDetector(
                    onTap:  _shareText,
                    child: ListTile(
                      leading:IconButton( onPressed: (){},
                        icon: Icon(Icons.share),
                      ),
                      title: Text('Share Url'),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'download',
                  child: GestureDetector(
                    onTap: () {
                      webViewController!.reload();
                    },
                    child: ListTile(
                      leading: IconButton( onPressed: () {

                      },
                        icon: Icon(Icons.refresh),
                      ),
                      title: Text('Refresh'),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Dark Theme',
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DarkThemeScreen()),
                      );
                    },
                    child: ListTile(
                      leading: IconButton( onPressed: () {
                      },
                        icon: Icon(Icons.dashboard),
                      ),
                      title: Text('Theme Sitting'),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'download',
                  child: GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const  SingleDownloadScreen()),
                      );
                    },
                    child: ListTile(
                      leading: IconButton( onPressed: ()  {

                      },
                        icon: Icon(Icons.download),
                      ),
                      title: Text('Dwonload Files'),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'download',
                  child: GestureDetector(
                    onTap:  toggleFullScreen,
                    child: ListTile(
                      leading: IconButton( onPressed: () {
                      },
                        icon: Icon(Icons.fullscreen),
                      ),
                      title: Text('Full Screen'),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'download',
                  child: GestureDetector(
                    onTap:  () async {
                      contentBlockerEnabled = !contentBlockerEnabled;
                      if (contentBlockerEnabled) {
                        await webViewController?.setSettings(
                            settings: InAppWebViewSettings(
                                contentBlockers: contentBlockers));
                      } else {
                        await webViewController?.setSettings(
                            settings: InAppWebViewSettings(contentBlockers: []));
                      }
                      webViewController?.reload();

                      setState(() {});
                    },
                    child: ListTile(
                      leading: IconButton( onPressed: () async {

                      },
                        icon: Icon(Icons.safety_check_outlined),
                      ),
                      title: Text('Add-Block '),
                    ),
                  ),
                ),

              ];
            },
          ),
        ],

      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
                alignment: Alignment.center,
                children: [
                  InAppWebView(
                    onLoadStart:(Controller,url){
                      var v=url.toString();
                      setState(() {
                        isloading=true;
                        urlController.text=v;
                      });

                    },

                    onLoadStop: (controller,url){
                      refreshController!.endRefreshing();
                      setState(() {
                        isloading=false;
                      });
                    },
                    pullToRefreshController: refreshController,
                    onWebViewCreated: (controller)=>webViewController=controller,

                    initialUrlRequest: URLRequest(url:WebUri(initialurl)),
                    initialSettings:InAppWebViewSettings(contentBlockers: contentBlockers),


                  ),
                  Visibility(
                    visible: isloading,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.red),
                    ),),]
            ),
          ),

        ],
      ) ,
    );
  }
  void toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    }
    );

  }
}
