import 'package:flutter/material.dart';

Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // allows rounded corners
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      ListTile(
                        title: Text("Wood works/Furniture's"),
                        onTap: () => Navigator.pop(context),
                      ),
                      ListTile(
                        title: Text('Electrical'),
                        onTap: () => Navigator.pop(context),
                      ),
                      // more items
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
