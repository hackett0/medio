import 'package:flutter/material.dart';
import 'package:medio/views/MineView.dart';

class MListView extends StatefulWidget {
  const MListView({super.key});

  @override
  State<MListView> createState() => _MListViewState();
}

class _MListViewState extends State<MListView> {
  Widget buildSliverList([int count = 5]) {
    return SliverToBoxAdapter(
      child: Container(
        height: 200.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 100,
          itemBuilder: (context, index) {
            return Container(
              width: 120.0,
              child: Card(
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildHeader(int i) {
    return SliverPersistentHeader(
      pinned: false,
      floating: false,
      delegate: SliverHeaderDelegate(
        maxHeight: 60,
        minHeight: 60,
        child: Center(
          child: Row(
            children: [
              Text("热门推荐 $i"),
              Expanded(child: Container()),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DiscoverChildPage(title: '$widget.title')));
                    print('$widget.title');
                  },
                  child: Text("查看全部")),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildHeader(1),
        buildSliverList(),
        buildHeader(2),
        buildSliverList(),
        buildHeader(3),
        buildSliverList(),
        buildHeader(4),
        buildSliverList(),
        buildHeader(5),
        buildSliverList(),
      ],
    );
  }
}

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  // child 为 header
  SliverHeaderDelegate({
    required this.maxHeight,
    this.minHeight = 0,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  //最大和最小高度相同
  SliverHeaderDelegate.fixedHeight({
    required double height,
    required Widget child,
  })  : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  SliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });

  final double maxHeight;
  final double minHeight;
  final SliverHeaderBuilder builder;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    Widget child = builder(context, shrinkOffset, overlapsContent);
    //测试代码：如果在调试模式，且子组件设置了key，则打印日志
    assert(() {
      if (child.key != null) {
        print('${child.key}: shrink: $shrinkOffset，overlaps:$overlapsContent');
      }
      return true;
    }());
    // 让 header 尽可能充满限制的空间；宽度为 Viewport 宽度，
    // 高度随着用户滑动在[minHeight,maxHeight]之间变化。
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverHeaderDelegate old) {
    return old.maxExtent != maxExtent || old.minExtent != minExtent;
  }
}
