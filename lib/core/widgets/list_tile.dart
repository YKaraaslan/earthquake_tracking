import 'package:flutter/material.dart';

import '../constant/styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, 
  required this.value, 
  required this.title, 
  required this.subtitle, 
  required this.time, 
  required this.fun, 
  required this.iconData}) : super(key: key);
  final String value, title, subtitle, time;
  final Function fun;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(value, style: listTileValueStyle,),
      title: Text(title),
      subtitle: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(subtitle)
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(time)
            ),
          ],
        ),
      ),
      trailing: IconButton(
            icon: Icon(iconData), 
            onPressed: () => fun,
          ),
    );
  }
}