import 'package:flutter/material.dart';
import 'package:sih_pipeline_project/components/my_button.dart';
import 'package:sih_pipeline_project/components/text_field.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

final dio = Dio();

class MyLoginPage extends StatefulWidget {
  MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _myBox = Hive.box('progressBox');

  //text editing controllers
  final locationIDController = TextEditingController();

  final workerIDController = TextEditingController();

  final passwordController = TextEditingController();

  //signUserIn
  void signUserIn(BuildContext context) async {
    final currentLocationID = locationIDController.text;
    final currentWorkerID = workerIDController.text;
    final currentPassword = passwordController.text;

    if (currentLocationID == "" ||
        currentWorkerID == "" ||
        currentPassword == "") {
      Fluttertoast.showToast(
          msg: 'One of the input field is missing',
          backgroundColor: Colors.black,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16);
      return;
    }

    print('Current Location-ID:' +
        currentLocationID +
        ' Worker-ID:' +
        currentWorkerID +
        ' Current Password:' +
        currentPassword);

    try {
      // Handle the response
      Response response =
          await dio.post('http://localhost:4000/flutter/workerLogIn', data: {
        'workerID': currentWorkerID,
        'pipeLocationID': currentLocationID,
        'password': currentPassword
      });

      //Setting Headers
      response.headers.set("Content-Type", "application/json; charset=UTF-8");
      Map<String, dynamic> responseData = response.data;

      print(responseData["msg"]);

      if (responseData["msg"] == "User found in DB") {
        print('Response Data at Login from DB\n');
        print(responseData);

        //Store the cached data in hiveDB
        _myBox.put('currentProgress', responseData["currentProgress"]);
        //Set water theft as false
        _myBox.put('waterTheft', false);

        //then route to main page with json values from DB
        Navigator.pushNamed(context, '/mainpage', arguments: responseData);

        return;
      } else {
        //Unsuccessfull login
        Fluttertoast.showToast(
            msg: 'User not found in Database',
            backgroundColor: Colors.black,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16);
      }
    } catch (e) {
      // Handle errors, log, or display an error message
      print('Error: $e');
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 100),

            //Icon
            Image.asset('lib/images/pipe.png', height: 100),

            const SizedBox(height: 20),

            Text(
              'SIH Pipe-Management Login',
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 25),

            //Location ID
            MyTextField(
              controller: locationIDController,
              obscureText: false,
              hintText: 'Enter Pipe-Location ID',
            ),

            const SizedBox(height: 25),

            //Worker ID
            MyTextField(
              controller: workerIDController,
              obscureText: false,
              hintText: 'Enter your Supervisor-ID',
            ),

            //Password
            const SizedBox(height: 25),

            MyTextField(
              controller: passwordController,
              obscureText: true,
              hintText: 'Enter your password',
            ),

            const SizedBox(height: 25),

            MyButton(
              onTap: () => signUserIn(context),
            )
          ]),
        ),
      ),
    );
  }
}
