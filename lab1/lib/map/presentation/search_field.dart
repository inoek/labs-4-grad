import 'package:bristol_app/app/presentation/styles/colors.dart';
import 'package:bristol_app/app/presentation/styles/text_themes.dart';
import 'package:bristol_app/generated/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
    this.onChanged,
    this.placeholder,
    this.autofocus = true,
  }) : super(key: key);

  final ValueChanged<String?>? onChanged;

  final String? placeholder;

  final bool autofocus;

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _controller,
      onChanged: widget.onChanged,
      autofocus: widget.autofocus,
      placeholder: widget.placeholder,
      placeholderStyle: onyx04TextTheme.bodyText1,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: BoxDecoration(
          color: BristolColors.white,
          border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor))),
      suffixMode: OverlayVisibilityMode.editing,
      suffix: GestureDetector(onTap: _clear, child: Assets.icons.close.svg()),
      cursorColor: BristolColors.main,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call(null);
  }
}
