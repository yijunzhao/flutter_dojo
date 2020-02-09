import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dojo/common/main_title_widget.dart';

class KeyWidget extends StatefulWidget {
  @override
  _KeyWidgetState createState() => _KeyWidgetState();
}

class _KeyWidgetState extends State<KeyWidget> {
  var statelessItems;
  var statefulWithKeyItems;
  var statefulWithoutKeyItems;
  var statefulWithKeyAndPaddingItems;
  var item;

  var isStateful = false;
  var isUseKey = false;
  var isTop = true;

  var slider = 20.0;

  @override
  void initState() {
    super.initState();
    statelessItems = [
      StatelessItem(),
      StatelessItem(),
    ];
    statefulWithKeyItems = [
      StatefulItem(key: UniqueKey()),
      StatefulItem(key: UniqueKey()),
    ];
    statefulWithoutKeyItems = [
      StatefulItem(),
      StatefulItem(),
    ];
    statefulWithKeyAndPaddingItems = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StatefulItem(key: UniqueKey()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: StatefulItem(key: UniqueKey()),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (isStateful) {
      if (isUseKey) {
        if (isTop) {
          item = statefulWithKeyItems;
        } else {
          item = statefulWithKeyAndPaddingItems;
        }
      } else {
        item = statefulWithoutKeyItems;
      }
    } else {
      item = statelessItems;
    }
    return ListView(
      children: <Widget>[
        MainTitleWidget('LocalKey的基本使用'),
        Row(children: item),
        Row(
          children: <Widget>[
            Text('是否是StatefulWidget'),
            Spacer(),
            Switch(
              value: isStateful,
              onChanged: (v) {
                setState(() => isStateful = v);
              },
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text('StatefulWidget是否使用Key'),
            Spacer(),
            Switch(
              value: isUseKey,
              onChanged: isStateful ? (v) => setState(() => isUseKey = v) : null,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text('Key是否设置在最顶层'),
            Spacer(),
            Switch(
              value: isTop,
              onChanged: isStateful ? (v) => setState(() => isTop = v) : null,
            ),
          ],
        ),
        RaisedButton(
          onPressed: changeColor,
          child: Text('Change Color'),
        ),
      ],
    );
  }

  changeColor() {
    setState(() => item.insert(1, item.removeAt(0)));
  }
}

class StatelessItem extends StatelessWidget {
  final color = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}

class StatefulItem extends StatefulWidget {
  @override
  _StatefulItemState createState() => _StatefulItemState();

  StatefulItem({Key key}) : super(key: key);
}

class _StatefulItemState extends State<StatefulItem> {
  final color = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}