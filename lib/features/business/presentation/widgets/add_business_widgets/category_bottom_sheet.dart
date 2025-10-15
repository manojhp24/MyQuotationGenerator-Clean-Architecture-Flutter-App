import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';

Future<T?> showEnumSelectionSheet<T>(BuildContext context, {
  required List<T> values,
  required String Function(T) labelBuilder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16)),
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
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: values.length,
                    itemBuilder: (context, index) {
                      final item = values[index];
                      return ListTile(
                        title: Text(labelBuilder(item),
                          style: AppTextStyle.bodyMedium(context),),
                        onTap: () => Navigator.pop(context, item),
                      );
                    },
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
