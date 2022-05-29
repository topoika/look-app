import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: w * 1,
              height: h * 0.3,
              child: GridView(
                padding: const EdgeInsets.all(25),
                children: [
                  TextButton(
                    onPressed: () {},
                    child: buildContainer('Maths', Colors.amber),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: buildContainer('Chemistry', Colors.indigo),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: buildContainer('Physics', Colors.lime),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: buildContainer('Biology', Colors.black12),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: buildContainer('English', Colors.deepPurple),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: buildContainer('History', Colors.deepOrange),
                  ),
                ],
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Join ",
                  style: TextStyle(
                      fontSize: w * 0.050,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontFamily: 'PopR')),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  bottom: MediaQuery.of(context).size.width * 0.03),
              width: MediaQuery.of(context).size.width * 0.28,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(
                  // color: Colors.transparent,
                  color: Colors.pinkAccent,
                  width: 3.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(
                        25.0) //                 <--- border radius here
                    ),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text("Go Live",
                    style: TextStyle(
                        fontSize: w * 0.050,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'PopR')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(String screenName, Color clr) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: clr,
      ),
      child: Center(
        child: Text(
          screenName,
        ),
      ),
    );
  }
  // Future<void> onJoin() async
  // {
  //   await [Permission.camera,Permission.microphone].request();
  //   Get.to(const LiveClass(channelName:"Khan",isBroadcaster:true));
  // }
  // Future<void> onjoin() async
  // {
  //   await [Permission.camera,Permission.microphone].request();
  //   Get.to(const LiveClass(channelName:"Khan",isBroadcaster:false));
  // }
}
