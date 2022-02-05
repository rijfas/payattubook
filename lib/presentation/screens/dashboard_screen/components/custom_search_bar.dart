import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    Key? key,
    required TextEditingController controller,
    required void Function() onSearch,
    String hintText = 'Search people',
  })  : _controller = controller,
        _onSearch = onSearch,
        _hintText = hintText,
        super(key: key);
  final TextEditingController _controller;
  final void Function() _onSearch;
  final String _hintText;

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
              onChanged: (_) {
                setState(() {});
              },
              controller: widget._controller,
              onEditingComplete: widget._onSearch,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget._hintText,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.lightSecondaryColor,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (widget._controller.value.text != '')
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  widget._controller.clear();
                });
              },
            )
        ],
      ),
    );
  }
}
