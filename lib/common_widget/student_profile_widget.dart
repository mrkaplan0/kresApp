import 'package:flutter/material.dart';
import 'package:krestakipapp/common_widget/image_widget.dart';
import 'package:krestakipapp/models/student.dart';

class StudentProfileWidget extends StatelessWidget {
  final Student student;

  StudentProfileWidget(this.student);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.orangeAccent.shade100),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(17)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 10),
            ImageWidget(student),
            SizedBox(height: 10),
          ],
        ),
      );
}
