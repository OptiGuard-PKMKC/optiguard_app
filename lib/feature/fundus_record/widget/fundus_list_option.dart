import 'package:flutter/material.dart';

class BottomSheetOption {
  final String title;
  final Icon icon;
  final Function onTap;

  const BottomSheetOption({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

Future<dynamic> buildBottomSheetOption(
    BuildContext context, List<BottomSheetOption> options) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
    ),
    clipBehavior: Clip.hardEdge,
    builder: (BuildContext context) {
      return Wrap(
        children: options
            .map((option) => _buildOption(context, option))
            .toList(growable: false),
      );
    },
  );
}

ListTile _buildOption(BuildContext context, BottomSheetOption option) {
  return ListTile(
    leading: option.icon,
    title: Text(option.title),
    onTap: () {
      Navigator.pop(context);
      option.onTap();
    },
  );
}
