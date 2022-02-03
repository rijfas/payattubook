import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
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
              controller: _controller,
              onEditingComplete: _onSearch,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _hintText,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.lightSecondaryColor,
                ),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const Icon(Icons.published_with_changes_sharp)
        ],
      ),
    );
  }
}
