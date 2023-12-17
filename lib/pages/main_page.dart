import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> receivedData =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //Prop drilled data :
    // print(receivedData['currentProgress']);
    // print(receivedData['user']);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 30,
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
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                worker_Container(),

                //Continer displaying Admin ID
                admin_Container(),

                //Progress indicator bar
                progress_Element()
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            //Stages Containers
            stage_Container("Stage 1"),
            stage_Container("Stage 2"),
            stage_Container("Stage 3"),
            stage_Container("Stage 4"),
            stage_Container("Stage 5"),
          ]),
        ),
      ),
    );
  }

  Container stage_Container(String stageNum) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 239, 125, 125),
              Color.fromARGB(255, 140, 201, 234)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(left: 70, right: 70, top: 10),
      padding: EdgeInsets.all(20),
      child: Row(children: [
        Checkbox(
            value: false,
            onChanged: (bool? newValue) {
              setState(() {});
            }),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            stageNum,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }

  Container progress_Element() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: new CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 10.0,
        percent: 0.4,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [new Text('Progress'), new Text('40.0%')],
        ),
        progressColor: Colors.blue[300],
        backgroundColor: Color.fromARGB(255, 248, 135, 127),
        circularStrokeCap: CircularStrokeCap.round,
      ),
    );
  }

  Container admin_Container() {
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
            height: 70,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            'Admin ID',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            '1450',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 8.5, bottom: 8.5),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
    );
  }

  Container worker_Container() {
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
            height: 70,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            'Worker ID',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            '1450',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 20, right: 20, top: 8.5, bottom: 8.5),
      margin: EdgeInsets.only(top: 20),
    );
  }
}
