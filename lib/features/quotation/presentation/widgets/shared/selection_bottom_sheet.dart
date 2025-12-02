import 'package:flutter/material.dart';

Future<T?> showSelectBottomSheet<T>({
  required BuildContext context,
  required String title,
  required List<T> items,
  required Widget Function(T item) tileBuilder,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, controller) {
          if (items.isEmpty) {
            return Center(child: Text("No items found"));
          }

          return Column(
            children: [
              const SizedBox(height: 10),

              // Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "$title (${items.length})",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const Divider(),

              Expanded(
                child: ListView.separated(
                  controller: controller,
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (_, index) {
                    final item = items[index];

                    return InkWell(
                      onTap: () => Navigator.pop(context, item),
                      child: tileBuilder(item),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
