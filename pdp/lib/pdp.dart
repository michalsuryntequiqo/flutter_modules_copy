library pdp;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdp/src/data/product.dart';
import 'package:pdp/src/pdp_navigation_bar.dart';

class Pdp extends StatelessWidget {
  final String backLabel;
  final String productBuyLabel;
  final Product product;
  final VoidCallback onSavedPressed;
  final VoidCallback onBuyPressed;

  const Pdp(this.product, this.onSavedPressed, this.onBuyPressed,
      this.backLabel, this.productBuyLabel,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: _buildNavigationBar(context),
      child: _buildProductContent(context),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return CupertinoNavigationBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: true,
      previousPageTitle: backLabel,
      actionsForegroundColor: Theme.of(context).primaryColorDark,
      trailing: PdpNavigationBar(
          product.isSaved, onSavedPressed, onBuyPressed, productBuyLabel),
    );
  }

  Widget _buildProductContent(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
