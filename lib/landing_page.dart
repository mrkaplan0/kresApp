import 'package:flutter/material.dart';
import 'package:krestakipapp/View_models/user_model.dart';
import 'package:krestakipapp/homepage-visitor/home_page.dart';
import 'package:provider/provider.dart';
import 'signin/0_login_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: true);

    if (_userModel.state == ViewState.idle) {
      if (_userModel.users == null) {
        return LoginPage();
      } else {
        switch (_userModel.users!.position) {
          case 'visitor':
            return HomePage();
          default:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    /*  if (_userModel.users!.isAdmin == true) {
          return AdminSettings();
        } else {
          if (_userModel.users!.position == 'Öğretmen') {
            return TeacherHomePage();
          }
          else {

          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }*/
  }
}
