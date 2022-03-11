import 'package:flutter/material.dart';
import 'package:krestakipapp/View_models/user_model.dart';
import 'package:krestakipapp/common_widget/menu_items.dart';
import 'package:krestakipapp/constants.dart';
import 'package:krestakipapp/homepage-admin/student_settings/add_Student.dart';
import 'package:krestakipapp/homepage-admin/student_settings/fast_rating_page.dart';
import 'package:krestakipapp/homepage-admin/student_settings/student_list.dart';
import 'package:krestakipapp/models/student.dart';
import 'package:provider/provider.dart';

class StudentManagement extends StatefulWidget {
  @override
  State<StudentManagement> createState() => _StudentManagementState();

  StudentManagement();
}

class _StudentManagementState extends State<StudentManagement> {
  List<Student>? stuList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Öğrenci Yönetim Ekranı",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(kdefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 5),
                children: [
                  MenuItems(
                    itemColor: itemColor4,
                    itemText: ' Öğrenci Ekle',
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddStudent()));
                    },
                    icon: Icons.person_add_alt_1_rounded,
                  ),
                  MenuItems(
                    itemColor: itemColor2,
                    itemText: 'Öğrenci Listesi',
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StudentListPage()));
                    },
                    icon: Icons.school_rounded,
                  ),
                  MenuItems(
                    itemColor: itemColor3,
                    itemText: 'Hızlı Değerlendirme',
                    onPress: () async {
                      final UserModel _userModel =
                          Provider.of<UserModel>(context, listen: false);

                      await _userModel
                          .getStudentFuture()
                          .then((value) => stuList = value);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FastRating(stuList!)));
                    },
                    icon: Icons.person,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
