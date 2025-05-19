import 'package:flutter/material.dart';

import '../../models/list_item_model.dart';

class List1Widget extends StatelessWidget {
  const List1Widget(
      {super.key,
      required this.items,
      this.background,
      this.textColor,
      required this.onTap,
      this.onDelete,
      this.onEdit});
  final List<ListItemModel> items;
  final Color? background;
  final Color? textColor;
  final void Function(int index) onTap;
  final void Function(int index)? onEdit;
  final void Function(int index)? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                onTap(index);
              },
              child: Container(
                  padding: background != null
                      ? const EdgeInsets.all(16)
                      : EdgeInsets.zero,
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (items[index].icon != null)
                        Container(
                          width: 48,
                          height: 48,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.red),
                          child: Icon(items[index].icon),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              items[index].title,
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            if (items[index].description != null)
                              Text(
                                items[index].description!,
                                style: TextStyle(color: textColor),
                              ),
                          ],
                        ),
                      ),
                      if (onEdit != null && onDelete != null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PopupMenuButton<int>(
                              child: Container(
                                height: 24,
                                width: 24,
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.more_vert,
                                  color: textColor,
                                ),
                              ),
                              onSelected: (int item) {
                                if (item == 1) {
                                  onEdit!(index);
                                } else if (item == 2) {
                                  onDelete!(index);
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<int>>[
                                const PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text('Editar'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text('Excluir'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  )),
            ));
  }
}
