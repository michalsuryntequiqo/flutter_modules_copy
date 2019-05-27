import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdp/src/save_icon.dart';

class SaveProductButton extends StatefulWidget {
  final bool isSaved;
  final VoidCallback onPressed;

  bool get _isEnabled => onPressed != null;

  const SaveProductButton({
    Key key,
    this.isSaved = false,
    this.onPressed,
  }) : super(key: key);

  @override
  _SaveProductButtonState createState() => _SaveProductButtonState();
}

class _SaveProductButtonState extends State<SaveProductButton> {
  bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.all(0),
      onPressed: widget._isEnabled ? _toggleSaved : null,
      child: SaveIcon(
        isSaved: _isSaved,
        savedColor: Theme.of(context).accentColor,
        unsavedColor: Theme.of(context).cursorColor,
      ),
    );
  }

  void _toggleSaved() {
    setState(() {
      _isSaved = !_isSaved;
    });
    widget.onPressed();
  }
}
