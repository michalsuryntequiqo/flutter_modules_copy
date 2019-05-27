import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdp/src/product_save_button.dart';

class PdpNavigationBar extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onSavedPressed;
  final VoidCallback onBuyPressed;
  final String productBuy;

  const PdpNavigationBar(
    this.isSaved,
    this.onSavedPressed,
    this.onBuyPressed,
    this.productBuy, {
    Key key,
  })  : assert(isSaved != null),
        assert(productBuy != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildSaveIconButton(context),
        _buildBuyButton(context),
      ],
    );
  }

  Widget _buildBuyButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: CupertinoButton(
        padding: EdgeInsets.only(left: 16, right: 16, top: 0),
        color: Theme.of(context).accentColor,
        onPressed: onBuyPressed,
        child: Text(
          productBuy,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveIconButton(BuildContext context) {
    return SaveProductButton(
      key: Key('save-product'),
      isSaved: isSaved,
      onPressed: onSavedPressed,
    );
  }
}
