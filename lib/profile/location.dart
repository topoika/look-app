
import 'package:flutter/material.dart';
//import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:location/location.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/firebase/database/database.dart';
import 'package:look/firebase/signin.dart';
import 'package:look/liveusers/liveusers.dart';



class GetUserLocation extends StatefulWidget {
  const GetUserLocation({Key? key}) : super(key: key);


  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  //LocationData? currentLocation;
  String address = "";
  int len=0;
  bool loading=false;
  final TextEditingController _describeController=TextEditingController();
  final TextEditingController _jobController=TextEditingController();
  final TextEditingController _locationController=TextEditingController();

  @override
  @mustCallSuper
  void initState() {
    _locationController.text='';
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h= MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child:(loading==false)?SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_back_ios_outlined,color: Colors.black45,),
                  ),
                  TextButton(
                      onPressed: (){
                    if(_locationController.text=='')
                      {
                        try
                        {
                          if(IMAGESELECTED==true) {
                            DatabaseService().regUser(email: EMAIL,name: NAME,country: COUNTRY,dob: DATE,location: LOCATION,
                                job: JOB,describe: DESCRIBE,education: EDUCATION,phone: PHONE,gender: GENDER,photo: PHOTO,marital: MARITAL,
                                drinking: DRINKING,smoking: SMOKING,eating: EATING,personality: PERSONALITY,interests: INTERESTS,uid: UID);
                          }
                          else
                          {
                            DatabaseService().regUser2(email: EMAIL,name: NAME,country: COUNTRY,dob: DATE,location: LOCATION,
                                job: JOB,describe: DESCRIBE,education: EDUCATION,phone: PHONE,gender: GENDER,marital: MARITAL,
                                drinking: DRINKING,smoking: SMOKING,eating: EATING,personality: PERSONALITY,interests: INTERESTS,uid: UID);
                          }

                          Get.to(const LiveUsers());
                        }catch(e)
                        {
                          print("Error");
                          print(e.toString());
                          final snackBar = SnackBar(
                            margin: const EdgeInsets.all(20),
                            behavior: SnackBarBehavior.floating,
                            content: const Text('Check your internet connection!'),
                            backgroundColor: (Colors.redAccent),
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        }
                      }
                    else
                      {
                        LOCATION=_locationController.text;
                        DESCRIBE=_describeController.text;
                        JOB=_jobController.text;
                        try {
                          if(IMAGESELECTED==true) {
                            DatabaseService().regUser(email: EMAIL,name: NAME,country: COUNTRY,dob: DATE,location: LOCATION,
                            job: JOB,describe: DESCRIBE,education: EDUCATION,phone: PHONE,gender: GENDER,photo: PHOTO,marital: MARITAL,
                            drinking: DRINKING,smoking: SMOKING,eating: EATING,personality: PERSONALITY,interests: INTERESTS,uid: UID);
                          }
                          else
                            {
                              DatabaseService().regUser2(email: EMAIL,name: NAME,country: COUNTRY,dob: DATE,location: LOCATION,
                                  job: JOB,describe: DESCRIBE,education: EDUCATION,phone: PHONE,gender: GENDER,marital: MARITAL,
                                  drinking: DRINKING,smoking: SMOKING,eating: EATING,personality: PERSONALITY,interests: INTERESTS,uid: UID);
                            }
                          Get.to(const LiveUsers());
                        }catch(e)
                    {
                      print(e.toString());
                      final snackBar = SnackBar(
                        margin: const EdgeInsets.all(20),
                        behavior: SnackBarBehavior.floating,
                        content: const Text('Check your internet connection!'),
                        backgroundColor: (Colors.redAccent),
                        action: SnackBarAction(
                          label: 'dismiss',
                          onPressed: () {
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                      }
                  }, child:Text("Skip    ",style: TextStyle(fontWeight: FontWeight.bold,fontSize:w*0.05,
                      fontFamily:"PopZ",color: Colors.black45),)
                  )
                ],
              ),
              Container(
                width: w*0.9,
                height: h*0.38,
                color: HexColor('#eceeef'),
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on,color: Colors.red,size: w*0.1,),
                          Text("Lives In",style: TextStyle(fontFamily: 'PopB',fontSize: w*0.055),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20),
                      child: TextFormField(
                        controller: _locationController,
                        maxLines: 2,
                        style: TextStyle(fontSize:w*0.05,fontFamily: "PopM",color: Colors.black54),
                        decoration: InputDecoration(
                          hintText: "      \nEnter Current location",
                          hintStyle: TextStyle(fontSize:w*0.04,fontFamily: "PopM",color: Colors.black87),
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            loading=true;
                          });
                          // _getLocation().then((value) {
                          //   LocationData? location = value;
                          //   _getAddress(location?.latitude, location?.longitude)
                          //       .then((value) {
                          //     setState(() {
                          //       currentLocation = location;
                          //       _locationController.text=value;
                          //     });
                          //   });
                          // });
                          setState(() {
                            loading=false;
                          });
                        },
                        child: Container(
                          margin:  EdgeInsets.only(top: h*0.06),
                          padding:const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:theme().mC,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:(loading==true) ?const Center(
                            child: CircularProgressIndicator(),
                          ):Text("Get Current Location",style: TextStyle(fontFamily: "PopZ",fontSize: w*0.05,color: Colors.black54),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: w*0.1,right: w*0.1,top: h*0.1,bottom: h*0.06),
                child: TextFormField(
                  controller: _jobController,
                  decoration: InputDecoration(
                    hintText: " in put your job",
                    hintStyle: TextStyle(fontSize:w*0.05,fontFamily: "PopB",color: Colors.black12),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: w*0.1,right: w*0.1),
                child: TextFormField(
                  controller: _describeController,
                  maxLength: 250,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Describe yourself",
                    hintStyle:  TextStyle(fontSize:w*0.05,fontFamily: "PopB",color: Colors.black12),
                  ),
                  onChanged: _onChanged,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text("$len/250           ",style: const TextStyle(fontFamily: "PopB",fontSize: 15),),
              )
            ],
          ),
        ):const Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
  _onChanged(String value) {
    setState(() {
      len= value.length;
    });
  }
  // Future<LocationData?> _getLocation() async {
  //   Location location = Location();
  //   LocationData _locationData;
  //
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return null;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return null;
  //     }
  //   }
  //
  //   _locationData = await location.getLocation();
  //
  //   return _locationData;
  // }

  // Future<String> _getAddress(double? lat, double? lang) async {
  //   if (lat == null || lang == null) return "";
  //   GeoCode geoCode = GeoCode();
  //   Address address =
  //   await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
  //   return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  // }
}
