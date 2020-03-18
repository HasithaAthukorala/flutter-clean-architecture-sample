import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/theme.dart';
import 'package:clean_architecture_with_bloc_app/core/widgets/custom_snak_bar.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/presentation/blocs/log_out/bloc.dart';

import '../../../../injection_container.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CustomSnackBar _snackBar;

  @override
  Widget build(BuildContext context) {
    _snackBar = CustomSnackBar(key: Key("snackbar"), scaffoldKey: _scaffoldKey);
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: CustomColor.statusBarColor,
        ),
        child: _buildBody(context),
      ),
    );
  }

  BlocProvider<LogOutBloc> _buildBody(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider<LogOutBloc>(
      create: (_) => sl<LogOutBloc>(),
      child: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(DEFAULT_PAGE_PADDING),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50)),
            Text(
              "Draft Home",
              style: CustomTheme.mainTheme.textTheme.title,
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 36,
                  child: _buildChangePasswordButton(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                ),
                Container(
                  width: double.infinity,
                  height: 36,
                  child: _buildSignOutButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder _buildSignOutButton() {
    return BlocBuilder<LogOutBloc, LogOutState>(
      condition: (prevState, currState) {
        if (currState is LoggedOutState) {
          _snackBar.hideAll();
          Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE, (r) => false);
        }
        return !(currState is LoggedOutState);
      },
      builder: (context, state) {
        if (state is LoggedInState || state is ErrorState) {
          if (state is ErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _snackBar.hideAll();
              _snackBar.showErrorSnackBar(state.message);
            });
          }
          return RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(4.0),
            ),
            color: CustomColor.logoBlue,
            onPressed: () {
              BlocProvider.of<LogOutBloc>(context).add(UserLogOutEvent());
            },
            child: Text(
              "SIGN OUT",
              style: CustomTheme.mainTheme.textTheme.button,
            ),
          );
        } else if (state is LoadingState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _snackBar.hideAll();
            _snackBar.showLoadingSnackBar();
          });
          return Container();
        }
        return Container();
      },
    );
  }

  RaisedButton _buildChangePasswordButton() {
    return RaisedButton(
      key: Key("changePassword"),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(4.0),
      ),
      color: CustomColor.logoBlue,
      onPressed: () {
        Navigator.pushNamed(context, CHANGE_PASSWORD_ROUTE);
      },
      child: Text(
        "CHANGE PASSWORD",
        style: CustomTheme.mainTheme.textTheme.button,
      ),
    );
  }
}
