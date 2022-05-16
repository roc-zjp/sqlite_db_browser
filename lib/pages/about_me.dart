import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("关于我"),
      ),
      body: ListView(children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Stack(
            children: [
              Image.asset(
                "assets/wave.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                  bottom: 20,
                  right: 90,
                  child: InkWell(
                    onTap: () async {
                      var _url =
                          Uri.parse('https://juejin.cn/user/272334611820622');
                      if (!await launchUrl(_url))throw 'Could not launch $_url';
                    },
                    child: _buildItem("assets/juejin.png", "掘金"),
                  )),
              Positioned(
                bottom: 20,
                right: 20,
                child: InkWell(
                  onTap: () async {
                    var _url = Uri.parse('https://github.com/roc-zjp');
                    if (!await launchUrl(_url)) throw 'Could not launch $_url';
                  },
                  child: _buildItem(
                    "assets/github.png",
                    "Github",
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "天涯浪子",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Text(
            "技术改变生活",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ),
        Column(
          children: [
            Image.asset(
              "assets/wechat.jpg",
            ),
            const Text(
              "我的微信",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        // _buildItem("assets/wechat.jpg", "我的微信", size: const Size(512, 512)),
        const Padding(padding: EdgeInsets.only(bottom: 20))
      ]),
    );
  }

  Widget _buildItem(String picPath, String text,
      {Size size = const Size(32.0, 32.0)}) {
    return Column(
      children: [
        Image.asset(
          picPath,
          width: size.width,
          height: size.height,
        ),
        Text(text)
      ],
    );
  }
}
