import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pr_mirro_well/controllers/providers/connectivity_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  InAppWebViewController? inAppWebViewController;
  String link = "https://www.google.com/";
  String SelectedOption = "Option 1";
  List<String> BookMark = [];
  String urlBookmark = "";

  TextEditingController SearchController = TextEditingController();
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvier>(context, listen: false)
        .checkInternetConnectvity();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(),
      onRefresh: () async {
        await inAppWebViewController?.reload();
        await Future.delayed(Duration(seconds: 1));
        pullToRefreshController?.endRefreshing();
      },
    );
  }

  void showAlertDialog(String selectedOption) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text("Search Engine"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile(
                  title: const Text("Google"),
                  value: "https://www.google.com/",
                  groupValue: link,
                  onChanged: (value) {
                    setState(() {
                      link = value!;
                    });
                    inAppWebViewController!.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(link),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  title: const Text("Yahoo"),
                  value: "https://www.yahoo.com/",
                  groupValue: link,
                  onChanged: (value) {
                    setState(() {
                      link = value!;
                    });
                    inAppWebViewController!.loadUrl(
                      urlRequest: URLRequest(
                        url: Uri.parse(link),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  title: const Text("Bing"),
                  value: "https://www.bing.com/",
                  groupValue: link,
                  onChanged: (value) {
                    setState(() {
                      link = value!;
                    });
                    inAppWebViewController!
                        .loadUrl(urlRequest: URLRequest(url: Uri.parse(link)));
                    Navigator.of(context).pop();
                  },
                ),
                RadioListTile(
                  title: const Text("Duck Duck Go"),
                  value: "https://duckduckgo.com/",
                  groupValue: link,
                  onChanged: (value) {
                    setState(() {
                      link = value!;
                    });
                    inAppWebViewController!
                        .loadUrl(urlRequest: URLRequest(url: Uri.parse(link)));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void bookmarklist(String selectedOption) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: const Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        label: const Text(
                          "Dismiss",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  child: ListView.builder(
                    itemCount: BookMark.length,
                    itemBuilder: (context, i) => ListTile(
                      title: Text("${BookMark[i]}"),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              BookMark.remove(BookMark[i]);
                              Navigator.of(context).pop();
                            });
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showDialogBox() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("No Connection"),
        content: Text("Please check your internet connectivity"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Browser',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              PopupMenuButton(
                offset: const Offset(10, 60),
                shape: const OutlineInputBorder(),
                icon: const Icon(Icons.more_vert, color: Colors.black),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "Option 1",
                    child: Row(
                      children: [
                        const Icon(Icons.bookmark_add_outlined,
                            color: Colors.black),
                        SizedBox(
                          width: w * 0.04,
                        ),
                        const Text("All BookMark"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: "Option 2",
                    child: Row(
                      children: [
                        const Icon(Icons.laptop, color: Colors.black),
                        SizedBox(
                          width: w * 0.04,
                        ),
                        const Text("Search Engine"),
                      ],
                    ),
                  ),
                ],
                onSelected: (selectedOption) {
                  setState(() {
                    SelectedOption = selectedOption;
                  });
                  if (selectedOption == "Option 1") {
                    bookmarklist(selectedOption);
                  } else if (selectedOption == "Option 2") {
                    showAlertDialog(selectedOption);
                  }
                },
              ),
            ],
          ),
          body: (Provider.of<ConnectivityProvier>(context)
                      .connectivityModel
                      .ConnectivityStatus ==
                  "Waiting..")
              ? Center(
                  child: Text("Please check your intrnet connection",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                )
              : Container(
                  height: h * 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: h * 0.74,
                          child: InAppWebView(
                            pullToRefreshController: pullToRefreshController,
                            onWebViewCreated: (controller) {
                              inAppWebViewController = controller;
                            },
                            onLoadStart: (controller, url) {
                              setState(() {
                                inAppWebViewController = controller;
                                urlBookmark = url.toString();
                              });
                            },
                            onLoadStop: (controller, url) async {
                              await pullToRefreshController?.endRefreshing();
                            },
                            initialUrlRequest: URLRequest(url: Uri.parse(link)),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.15,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: SearchController,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: const Icon(
                                          Icons.search,
                                        ),
                                        onPressed: () {
                                          String newLink =
                                              SearchController.text;
                                          inAppWebViewController?.loadUrl(
                                            urlRequest: URLRequest(
                                              url: (SelectedOption.isEmpty)
                                                  ? Uri.parse(
                                                      "https://www.google.com/")
                                                  : Uri.parse(
                                                      "${link}search?q=$newLink"),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await inAppWebViewController?.loadUrl(
                                          urlRequest: URLRequest(
                                            url: Uri.parse(link),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.home, size: 35),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          BookMark.add(urlBookmark);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.bookmark_add_outlined,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        if (await inAppWebViewController!
                                            .canGoBack()) {
                                          await inAppWebViewController
                                              ?.goBack();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_left_outlined,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await inAppWebViewController?.reload();
                                      },
                                      icon: const Icon(
                                        Icons.refresh,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        if (await inAppWebViewController!
                                            .canGoForward()) {
                                          await inAppWebViewController
                                              ?.goForward();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_arrow_right_outlined,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}
