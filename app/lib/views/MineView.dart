import 'package:flutter/material.dart';
import 'package:medio/module/providers/SambaProvider.dart';

class Mine extends StatefulWidget {
  const Mine({super.key});

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> {
  Widget headerWidget() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              child: ListView(
                children: [
                  headerWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  DiscoverCell(
                    imageName: Icons.payment,
                    title: '支付',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DiscoverCell(
                    imageName: Icons.collections,
                    title: '收藏',
                  ),
                  Row(children: <Widget>[
                    Container(width: 50, height: 0.5, color: Colors.white),
                    Container(height: 0.5, color: Colors.grey)
                  ]), //分割线
                  DiscoverCell(
                    imageName: Icons.browse_gallery,
                    title: '相册',
                  ),
                  Row(
                    children: <Widget>[
                      Container(width: 50, height: 0.5, color: Colors.white),
                      Container(height: 0.5, color: Colors.grey)
                    ],
                  ), //分割线
                  DiscoverCell(
                    imageName: Icons.card_giftcard,
                    title: '卡包',
                  ),
                  Row(
                    children: <Widget>[
                      Container(width: 50, height: 0.5, color: Colors.white),
                      Container(height: 0.5, color: Colors.grey),
                    ],
                  ),
                  DiscoverCell(
                    imageName: Icons.emoji_emotions,
                    title: '表情',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DiscoverCell(
                    imageName: Icons.settings,
                    title: '设置',
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                child: Icon(Icons.camera),
                width: 25,
              ),
              right: 10,
              top: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class DiscoverCell extends StatefulWidget {
  final String? title;
  final IconData? imageName;
  final String? subTitle;
  final IconData? subImageName;

  DiscoverCell({required this.title, required this.imageName, this.subTitle, this.subImageName})
      : assert(title != null, "title 不能为空"),
        assert(imageName != null, "imageName 不能为空");

  @override
  _DiscoverCellState createState() => _DiscoverCellState();
}

class _DiscoverCellState extends State<DiscoverCell> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SambaProvider(),
            // DiscoverChildPage(title: '$widget.title'),
          ));
          print('$widget.title');
        },
        onTapCancel: () {},
        onTapDown: (TapDownDetails details) {},
        child: Container(
          height: 55,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    //image
                    Container(
                      child: Icon(widget.imageName!),
                      width: 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    //title
                    Text(widget.title!),
                  ],
                ),
              ),
              // right
              Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      // subtitle
                      Text(widget.subTitle ?? ""),
                      // subimage
                      widget.subImageName != null
                          ? Container(
                              child: Icon(widget.subImageName!),
                              width: 12,
                            )
                          : Container(),
                      //箭头
                      Container(
                        child: Icon(Icons.arrow_back),
                        width: 15,
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}

class DiscoverChildPage extends StatelessWidget {
  final String title;
  DiscoverChildPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
      ),
      body: Center(
        child: Text("$title"),
      ),
    );
  }
}
