import 'package:flutter/material.dart';

import 'dart:developer';
import 'main.dart';

class History extends StatelessWidget {
  final List<Calculation> result;
  final VoidCallback x;
  const History({Key? key, required this.x, required this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(result.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete history',
            onPressed: () {
              x();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: result.isEmpty
          ? Center(
              child: Text(
                'Empty!',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    ?.copyWith(fontSize: 12.0),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: result.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  title: Text(result[i].t),
                  subtitle: Text(result[i].x),
                  onTap: () => {
                    Navigator.pop(context, i),
                  },
                );
              },
            ),
    );
  }
}
