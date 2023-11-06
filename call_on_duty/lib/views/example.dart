import 'package:flutter/material.dart';

class DragAndDropGrid extends StatefulWidget {
  const DragAndDropGrid({Key? key}) : super(key: key);

  @override
  _DragAndDropGridState createState() => _DragAndDropGridState();
}

class _DragAndDropGridState extends State<DragAndDropGrid> {
  // A list of items to display in the grid
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
  ];

  // A list of items that are accepted by the drag target
  List<String> acceptedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Grid Example'),
      ),
      body: Column(
        children: [
          // A drag target that accepts items and deletes them
          DragTarget<String>(
            onAccept: (data) {
              setState(() {
                // Remove the item from the grid list
                items.remove(data);
                // Add the item to the accepted list
                acceptedItems.add(data);
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                height: 100,
                color: Colors.red,
                child: Center(
                  child: Text(
                    candidateData.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              );
            },
          ),
          // A grid view that displays the items as draggable widgets
          Expanded(
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return Draggable<String>(
                  data: items[index],
                  child: Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        items[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  feedback: Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.blue[300],
                    child: Center(
                      child: Text(
                        items[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  childWhenDragging: Container(
                    margin: EdgeInsets.all(8),
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
