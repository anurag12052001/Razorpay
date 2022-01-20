import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Razorpay
      razorpay; // creating variable for razorpay, using late so that we can initilize it later
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = new Razorpay(); // initilizing razorpay variable

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        handlerPaymentSuccess); // passing event as string and handler as function which we will use later
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  // @override
  // Void dispose() {
  //   super.initState();
  //   razorpay.clear();
  // }

  void openCheckout() {
    var options = {
      // here we will be using map which consists of key and value
      "key":
          "rzp_test_q0YaQm4TwBNSTA", //we'll get this key from razorpay when we signin
      "amount": num.parse(textEditingController.text) *
          100, // taking amount from user
      "name": "Sample App",
      "description": "payment for App",
      "prefill": {
        // jo details auto fill ho k ayenge jo phle se save honge
        "contact": "1597534568",
        "email": "asdfgh@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      },
      "theme": {"color": "#840001"},
    };

    try {
      // we are using try catch so that koi error aay toh aap crash na ho hume bs wo error print ho jy

      razorpay.open(options); // passing our map name open here
    } catch (e) {
      print(e.toString()); // string me erroe ko lane k liye
    }
  }

  void handlerPaymentSuccess() {
    print(
        "Payment Successful"); // payment,update, animation will be handled by handlerPaymentsuccess fuunction
    showToast("Payment successful",
        textStyle: TextStyle(
          color: Colors.green,
          fontSize: 25,
        ));
  }

  void handlerPaymentError() {
    print(
        "Error While Sending Money"); // errors will be handled by this function
    showToast("Error While Sending Money",
        textStyle: TextStyle(
          color: Colors.green,
          fontSize: 25,
        ));
  }

  void handlerExternalWallet() {
    print("Extenal Wallet");
    showToast("External wallet",
        textStyle: TextStyle(
          color: Colors.green,
          fontSize: 25,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Payment",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Container(
          child: Column(
            children: [
              TextField(
                controller:
                    textEditingController, // assigning text editing controller to take value from the user
                decoration: InputDecoration(hintText: "Enter Amount To Pay"),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    openCheckout(); // calling openCheckout function when button will be clicked
                  },
                  child: Text(
                    "Pay",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
