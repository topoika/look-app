import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'PaypalPayment.dart';

class MakePayment extends StatefulWidget {
  const MakePayment({Key? key}) : super(key: key);


  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {

  TextStyle style = const TextStyle(fontFamily: 'Open Sans', fontSize: 15.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(45.0),
            child:  AppBar(
              backgroundColor: Colors.white,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Paypal Payment Example',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Open Sans'),
                  ),
                ],
              ),
            ),
          ),
          body:Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PaypalPayment(
                              onFinish: (number) async {

                                // payment done
                                print('order id: '+number);

                              },
                            ),
                          ),
                        );


                      },
                      child: const Text('Pay with Paypal', textAlign: TextAlign.center,),
                    ),

                  ],
                ),
              )
          ),
        )
    );
  }

}