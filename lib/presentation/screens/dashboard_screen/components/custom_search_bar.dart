import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
    this.onClear,
    this.hintText = 'Search people',
  }) : super(key: key);
  final TextEditingController controller;
  final void Function() onSearch;
  final void Function()? onClear;
  final String hintText;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppTheme.lightInputBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              onChanged: (_) {
                setState(() {});
              },
              controller: widget.controller,
              onEditingComplete: widget.onSearch,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.lightSecondaryColor,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (widget.controller.value.text != '')
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  widget.controller.clear();
                });
                if (widget.onClear != null) {
                  widget.onClear!();
                }
              },
            )
        ],
      ),
    );
  }
}
