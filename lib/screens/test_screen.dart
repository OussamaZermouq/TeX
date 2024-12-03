import 'package:flutter/material.dart';

class DynamicWidgetExample extends StatefulWidget {
  @override
  _DynamicWidgetExampleState createState() => _DynamicWidgetExampleState();
}

class _DynamicWidgetExampleState extends State<DynamicWidgetExample> {
  List<String> dynamicData = ['Widget 1', 'Widget 2', 'Widget 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Widget Example'),
      ),
      body: Column(
        children: [
          // Display dynamic widgets
          for (String data in dynamicData)
            DynamicItemWidget(
              data: data,
              onDelete: () {
                setState(() {
                  dynamicData.remove(data);
                });
              },
            ),
          // Add button to dynamically add widgets
          ElevatedButton(
            onPressed: () {
              setState(() {
                dynamicData.add('Widget ${dynamicData.length + 1}');
              });
            },
            child: Text('Add Widget'),
          ),
        ],
      ),
    );
  }
}

class DynamicItemWidget extends StatelessWidget {
  final String data;
  final VoidCallback onDelete;

  const DynamicItemWidget({required this.data, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
