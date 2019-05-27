import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveIcon extends StatelessWidget {
  final bool isSaved;
  final Color savedColor;
  final Color unsavedColor;

  const SaveIcon({
    Key key,
    this.isSaved = false,
    this.savedColor,
    this.unsavedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      (isSaved) ? Icons.turned_in : Icons.turned_in_not,
      color: (isSaved)
          ? (savedColor ?? Theme.of(context).primaryColor)
          : (unsavedColor ?? Theme.of(context).iconTheme.color),
    );
  }
}
