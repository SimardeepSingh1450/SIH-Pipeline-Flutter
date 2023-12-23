import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hive_flutter/hive_flutter.dart';

final dio = Dio();

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    //Hive Fetching
    final _myBox = Hive.box('progressBox');
    dynamic waterTheftState = _myBox.get('waterTheft');
    print('Current-Progress from hive is \n');
    print(_myBox.get("currentProgress"));

    Map<String, dynamic> currentProgressData = _myBox.get("currentProgress");

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),

                //Location Management Page Container
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        'Location Actvity Management',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                      ),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                    ),

                    //LogOut Button Container
                    GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, '/')},
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                        ),
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 8.5, bottom: 8.5),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ],
                ),

                //Row component having both workerID and AdminID Containers
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Container displaying Worker ID
                    worker_Container(currentProgressData["workerID"]),

                    //Continer displaying Admin ID
                    admin_Container(currentProgressData["superVisorID"]),

                    //Progress indicator bar
                    progress_Element(
                        currentProgressData["currentProgressPercent"])
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                Text('Completed Stages'),
                Divider(),

                //Stages Containers
                Column(
                  children: currentProgressData.entries.map((quote) {
                    print('STAGE TASK : ${quote.key} : ${quote.value}');
                    if (quote.key == "stageOne" && quote.value == true) {
                      return stage_task(
                          "stageOne",
                          currentProgressData["workerID"],
                          currentProgressData["superVisorID"],
                          currentProgressData,
                          _myBox,
                          context);
                    } else if (quote.key == "stageTwo" && quote.value == true) {
                      return stage_task(
                          "stageTwo",
                          currentProgressData["workerID"],
                          currentProgressData["superVisorID"],
                          currentProgressData,
                          _myBox,
                          context);
                    } else if (quote.key == "stageThree" &&
                        quote.value == true) {
                      return stage_task(
                          "stageThree",
                          currentProgressData["workerID"],
                          currentProgressData["superVisorID"],
                          currentProgressData,
                          _myBox,
                          context);
                    } else if (quote.key == "stageFour" &&
                        quote.value == true) {
                      return stage_task(
                          "stageFour",
                          currentProgressData["workerID"],
                          currentProgressData["superVisorID"],
                          currentProgressData,
                          _myBox,
                          context);
                    } else if (quote.key == "stageFive" &&
                        quote.value == true) {
                      return stage_task(
                          "stageFive",
                          currentProgressData["workerID"],
                          currentProgressData["superVisorID"],
                          currentProgressData,
                          _myBox,
                          context);
                    } else {
                      return Container(
                        height: 0,
                      );
                    }
                  }).toList(),
                ),

                const SizedBox(
                  height: 10,
                ),
                //Pending Stages
                Text('Pending Stages'),
                Divider(),

                Column(
                  children: currentProgressData.entries.map((quote) {
                    print('${quote.key} : ${quote.value}');
                    if (quote.key == "stageOne" && quote.value == false) {
                      return fail_stage_task(
                          "stageOne",
                          currentProgressData["workerID"],
                          currentProgressData["superVisorID"],
                          currentProgressData,
                          _myBox,
                          context);
                    } else if (quote.key == "stageTwo" &&
                        quote.value == false) {
                      return fail_stage_task(
                          "stageTwo",
                          currentProgressData["workerID"],
                          currentProgressData["superVisorID"],
                          currentProgressData,
                          _myBox,
                          context);
                    } else if (quote.key == "stageThree" &&
                        quote.value == false) {
                      return fail_stage_task(
                          "stageThree",
                          currentProgressData["workerID"],
                          currentProgressData["superVisorID"],
                          currentProgressData,
                          _myBox,
                          context);
                    } else if (quote.key == "stageFour" &&
                        quote.value == false) {
                      return fail_stage_task(
                          "stageFour",
                          currentProgressData["workerID"],
                          currentProgressData["superVisorID"],
                          currentProgressData,
                          _myBox,
                          context);
                    } else if (quote.key == "stageFive" &&
                        quote.value == false) {
                      return stage_five_fail();
                    } else {
                      return Container(
                        height: 0,
                      );
                    }
                  }).toList(),
                ),

                //Rendering a message whhen all the stages are completed
                (currentProgressData["stageOne"] == true &&
                        currentProgressData["stageTwo"] == true &&
                        currentProgressData["stageThree"] == true &&
                        currentProgressData["stageFour"] == true &&
                        currentProgressData["stageFive"] == true)
                    ? Container(
                        child: Text('All Stages Completed'),
                      )
                    : Container(
                        height: 0,
                      ),

                //Send mail for water theft to Admin
                water_Theft(
                    _myBox,
                    context,
                    currentProgressData["workerID"],
                    currentProgressData["superVisorID"],
                    currentProgressData["superVisorName"],
                    currentProgressData["pipeLocationID"]),

                (waterTheftState == true)
                    ? Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 154, 254, 172),
                                Color.fromARGB(255, 252, 244, 139)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            )),
                        child: Text(
                          'Water Theft Mail Sent!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ))
                    : Container(height: 0)
              ]),
        ),
      ),
    );
  }

  GestureDetector water_Theft(
      final _myBox,
      BuildContext context,
      String workerID,
      String superVisorID,
      String superVisorName,
      String pipeLocationID) {
    void changeTheftState(final _myBox, String workerID, String superVisorID,
        String superVisorName, String pipeLocationID) async {
      //set the state to true
      dynamic existingValue = _myBox.get("waterTheft");
      existingValue = true;
      _myBox.put("waterTheft", existingValue);

      //DB Operations for sending Mail
      Map<String, dynamic> sendData = {
        'workerID': workerID,
        'pipeLocationID': pipeLocationID,
        'superVisorID': superVisorID,
        'superVisorName': superVisorName
      };
      Response response = await dio.post(
          'https://flutter-backend-deploy.onrender.com/flutter/theftMailer',
          data: sendData);

      //Setting Headers
      response.headers.set("Content-Type", "application/json; charset=UTF-8");
      //no need to manipulate or fetch data

      //refresh the page
      Navigator.pushNamed(context, '/mainpage');

      return;
    }

    return GestureDetector(
      onTap: () {
        changeTheftState(
            _myBox, workerID, superVisorID, superVisorName, pipeLocationID);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 25, right: 25, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 239, 125, 125),
                Color.fromARGB(255, 140, 201, 234)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )),
        child: Center(
            child: Text(
          "Send Water Theft Complaint",
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  Container fail_stage_task(
      String stageName,
      String workerID,
      String supervisorID,
      Map<String, dynamic> currentProgressData,
      final _myBox,
      BuildContext context) {
    Future<void> markCompleted(
        String stageName,
        String workerID,
        String supervisorID,
        Map<String, dynamic> currentProgressData,
        final _myBox,
        BuildContext context) async {
      Map<String, dynamic> sendData = {
        'workerID': workerID,
        'stageName': stageName,
        'superVisorID': supervisorID
      };
      Response response = await dio.post(
          'https://flutter-backend-deploy.onrender.com/flutter/workProgress',
          data: sendData);

      //Setting Headers
      response.headers.set("Content-Type", "application/json; charset=UTF-8");
      Map<String, dynamic> responseData = response.data;
      // print('Response after updating from backend is :\n');
      // print(responseData);

      print('New State of currentProgressData\n');
      print(responseData["backendData"]);

      print('Data in hive is :\n');
      print(_myBox.get("currentProgress"));

      //Updating data inside hive
      // _myBox.set("currentProgress", responseData["backendData"]);
      dynamic existingValue = _myBox.get("currentProgress");
      if (stageName == "stageOne") {
        existingValue["stageOne"] = true;
        existingValue["currentProgressPercent"] += 20;
      } else if (stageName == "stageTwo") {
        existingValue["stageTwo"] = true;
        existingValue["currentProgressPercent"] += 20;
      } else if (stageName == "stageThree") {
        existingValue["stageThree"] = true;
        existingValue["currentProgressPercent"] += 20;
      } else if (stageName == "stageFour") {
        existingValue["stageFour"] = true;
        existingValue["currentProgressPercent"] += 20;
      }

      _myBox.put("currentProgress", existingValue);

      //adter updating print
      print('After update in hive:\n');
      print(_myBox.get("currentProgress"));

      //reload
      Navigator.pushNamed(context, '/mainpage');

      return;
    }

    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 77, 77),
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 25, right: 25, top: 10),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: Row(children: [
        //Pending Image
        Image.asset(
          'lib/images/pipe_repair.png',
          height: 20,
        ),
        //Text Container
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            stageName == "stageOne"
                ? "Stage One"
                : stageName == "stageTwo"
                    ? "Stage Two"
                    : stageName == "stageThree"
                        ? "Stage Three"
                        : stageName == "stageFour"
                            ? "Stage Four"
                            : "Stage Five",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),

        //Spacer
        Spacer(),
        //Completed Message
        GestureDetector(
          onTap: () => {
            markCompleted(stageName, workerID, supervisorID,
                currentProgressData, _myBox, context)
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(8),
            child: (stageName != "stageFive")
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Image.asset(
                          'lib/images/tick.png',
                          height: 10,
                        ),
                      ),
                      Text(
                        'Mark as Completed',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
                      )
                    ],
                  )
                : Container(
                    height: 0,
                  ),
          ),
        )
      ]),
    );
  }

  Container stage_task(
      String stageName,
      String workerID,
      String supervisorID,
      Map<String, dynamic> currentProgressData,
      final _myBox,
      BuildContext context) {
    // print('workerID in stage_task is\n');
    // print(workerID);

    // print('superVisorID in stage_task is\n');
    // print(supervisorID);
    Future<void> markNotCompleted(
        String stageName,
        String workerID,
        String supervisorID,
        Map<String, dynamic> currentProgressData,
        final _myBox,
        BuildContext context) async {
      Map<String, dynamic> sendData = {
        'workerID': workerID,
        'stageName': stageName,
        'superVisorID': supervisorID
      };
      Response response = await dio.post(
          'https://flutter-backend-deploy.onrender.com/flutter/workProgress',
          data: sendData);

      //Setting Headers
      response.headers.set("Content-Type", "application/json; charset=UTF-8");
      Map<String, dynamic> responseData = response.data;
      // print('Response after updating from backend is :\n');
      // print(responseData);

      print('New State of currentProgressData\n');
      print(responseData["backendData"]);

      print('Data in hive is :\n');
      print(_myBox.get("currentProgress"));

      //Updating data inside hive
      // _myBox.set("currentProgress", responseData["backendData"]);
      dynamic existingValue = _myBox.get("currentProgress");
      if (stageName == "stageOne") {
        existingValue["stageOne"] = false;
        existingValue["currentProgressPercent"] -= 20;
      } else if (stageName == "stageTwo") {
        existingValue["stageTwo"] = false;
        existingValue["currentProgressPercent"] -= 20;
      } else if (stageName == "stageThree") {
        existingValue["stageThree"] = false;
        existingValue["currentProgressPercent"] -= 20;
      } else if (stageName == "stageFour") {
        existingValue["stageFour"] = false;
        existingValue["currentProgressPercent"] -= 20;
      } else if (stageName == "stageFive") {
        existingValue["stageFive"] = false;
        existingValue["currentProgressPercent"] -= 20;
      }

      _myBox.put("currentProgress", existingValue);

      //adter updating print
      print('After update in hive:\n');
      print(_myBox.get("currentProgress"));

      //reload
      Navigator.pushNamed(context, '/mainpage');

      return;
    }

    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 132, 190, 238),
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 25, right: 25, top: 10),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: Row(children: [
        //Pending Image
        Image.asset(
          'lib/images/completed.png',
          height: 20,
        ),
        //Text Container
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            stageName == "stageOne"
                ? "Stage One"
                : stageName == "stageTwo"
                    ? "Stage Two"
                    : stageName == "stageThree"
                        ? "Stage Three"
                        : stageName == "stageFour"
                            ? "Stage Four"
                            : "Stage Five",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),

        //Spacer
        Spacer(),
        //Completed Message
        GestureDetector(
          onTap: () => {
            markNotCompleted(stageName, workerID, supervisorID,
                currentProgressData, _myBox, context)
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image.asset(
                    'lib/images/cross.png',
                    height: 10,
                  ),
                ),
                Text(
                  'Mark as Not Completed',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }

  Container progress_Element(int percentage) {
    print('percentage is\n');
    print(percentage);

    return Container(
      margin: EdgeInsets.only(left: 10, top: 20),
      child: CircularPercentIndicator(
        radius: 40.0,
        lineWidth: 10.0,
        percent: percentage == 0
            ? 0.0
            : percentage == 20
                ? 0.2
                : percentage == 40
                    ? 0.4
                    : percentage == 60
                        ? 0.6
                        : percentage == 80
                            ? 0.8
                            : 1,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text(
              'Percentage',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
            ),
            new Text('${percentage}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8))
          ],
        ),
        progressColor: Colors.blue[300],
        backgroundColor: Color.fromARGB(255, 248, 135, 127),
        circularStrokeCap: CircularStrokeCap.round,
      ),
    );
  }

  Container admin_Container(String superVisorID) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[100],
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/images/admin.png',
            height: 30,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            'Admin ID',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
          ),
          Text(
            superVisorID,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 8.5, bottom: 8.5),
      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
    );
  }

  Container worker_Container(String workerID) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[100],
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/images/worker.png',
            height: 30,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            'Supervisor ID',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
          ),
          Text(
            workerID,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 8.5, bottom: 8.5),
      margin: EdgeInsets.only(right: 10, top: 20),
    );
  }
}

class stage_five_fail extends StatelessWidget {
  const stage_five_fail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 77, 77),
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 25, right: 25, top: 10),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: Row(children: [
        //Pending Image
        Image.asset(
          'lib/images/pipe_repair.png',
          height: 20,
        ),
        //Text Container
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            'Stage Five',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),

        //Spacer
        Spacer(),
        //Completed Message
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Image.asset(
                  'lib/images/yellow_sense.png',
                  height: 10,
                ),
              ),
              Text(
                'Sensors (Not Working)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
              )
            ],
          ),
        )
      ]),
    );
  }
}
