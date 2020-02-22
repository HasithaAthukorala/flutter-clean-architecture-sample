import 'package:flutter/material.dart';

class CustomSnackBar {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ScaffoldState scaffoldState;

  CustomSnackBar({this.scaffoldKey, this.scaffoldState})
      : assert(scaffoldState != null || scaffoldKey != null);

  void showErrorSnackBar(final msg) {
    showSnackBar(text: "Error: $msg", color: Colors.red[400]);
  }

  ScaffoldState get _state {
    return scaffoldKey == null ? scaffoldState : scaffoldKey.currentState;
  }

  void showLoadingSnackBar() {
    hideAll();
    final snackBar = SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 10.0),
          Text("Loading..."),
        ],
      ),
      backgroundColor: Colors.green[400],
      duration: Duration(minutes: 1),
    );
    _state?.showSnackBar(snackBar);
  }

  void showSnackBar({
    @required String text,
    Duration duration = const Duration(hours: 1),
    Color color,
    bool action = true,
  }) {
    hideAll();
    final snackBar = SnackBar(
      content: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: color ?? Colors.green[400],
      duration: duration,
      action: action
          ? SnackBarAction(
              label: "Clear",
              textColor: Colors.black,
              onPressed: () => _state.removeCurrentSnackBar(),
            )
          : null,
    );
    _state?.showSnackBar(snackBar);
  }

  void hideAll() {
    _state?.removeCurrentSnackBar();
  }
}
