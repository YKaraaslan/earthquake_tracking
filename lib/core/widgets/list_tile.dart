import 'package:flutter/material.dart';

import '../constant/styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, 
  required this.value, 
  required this.title, 
  required this.subtitle, 
  required this.time, 
  required this.fun}) : super(key: key);
  final String value, title, subtitle, time;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
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
              icon: const Icon(Icons.share_location), 
              onPressed: () => fun,
            ),
      ),
    );
  }
}
