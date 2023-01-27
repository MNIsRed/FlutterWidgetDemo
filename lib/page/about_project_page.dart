import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutProjectPage extends StatefulWidget {
  const AboutProjectPage({Key? key}) : super(key: key);

  @override
  State<AboutProjectPage> createState() => _AboutProjectPageState();
}

class _AboutProjectPageState extends State<AboutProjectPage> {
  String readMeText = "";

  Future<String?> loadAssert() async {
    return await rootBundle.loadString('static/text/readMe.md');
  }

  @override
  void initState() {
    loadAssert().then((value) => {
          setState(() => {readMeText = value ?? "数据未获取"})
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const paddingEdge = 15.0;
    double paddingTop =
        AppBar().preferredSize.height + MediaQuery.of(context).viewPadding.top;
    loadAssert().then((value) => {
      setState(() => {readMeText = value ?? "数据未获取"})
    }).catchError((error)=>{
      error.printError
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("关于本项目"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Markdown(
          padding: EdgeInsets.only(
              left: paddingEdge, right: paddingEdge, top: paddingTop),
          data: readMeText),
    );
  }
}
