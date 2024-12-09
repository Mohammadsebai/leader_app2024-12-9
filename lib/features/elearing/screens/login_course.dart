import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file_course.dart';

class LoginCourse extends StatefulWidget {
  final String universityName;
  final String depatmentName;
  final String courseName;
  final String cName;
  final String dName;
  

const LoginCourse({
    Key? key,
    required this.universityName,
    required this.depatmentName,
    required this.courseName, required this.cName, required this.dName,
  }) : super(key: key);
  @override
  State<LoginCourse> createState() => _LoginCourseState();
}


class _LoginCourseState extends State<LoginCourse> {
  @override
  Widget build(BuildContext context) {
 String universityName = widget.universityName;
 String depatmentName = widget.depatmentName;
 String courseName = widget.courseName;

    return  Scaffold(
      appBar: AppBar(title: Text(''),
      leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ),

          body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(widget.dName),
              Text(widget.cName),

              SizedBox(height: 30,),

              ElevatedButton(
                style: ButtonStyle(
                  fixedSize:
                  MaterialStateProperty.all(const Size.fromRadius(70),),
                ),
               onPressed: (){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FileCourse(
          universityName: universityName,
          depatmentName: depatmentName,
          courseName: courseName,
          type:'ملخصات'
          )));},
              child: Text('ملخصات'),
            ),




              SizedBox(height: 30,),
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize:
                  MaterialStateProperty.all(const Size.fromRadius(70),),
                ),
              onPressed: (){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FileCourse( 
                    universityName: universityName,
          depatmentName: depatmentName,
          courseName: courseName,
          type:'فيديوهات'
          )));},
              child: Text('فيديوهات'),
            ),


              SizedBox(height: 30,),
            ElevatedButton(
              style: ButtonStyle(
                  fixedSize:
                  MaterialStateProperty.all(const Size.fromRadius(70),),
                ),
              onPressed: (){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FileCourse( 
                    universityName: universityName,
          depatmentName: depatmentName,
          courseName: courseName,
          type:'سنوات'
          )));},
              child: Text('سنوات '),
            ),


              SizedBox(height: 30,),
              ]
              )
              )
              )
          
          );
  }
}