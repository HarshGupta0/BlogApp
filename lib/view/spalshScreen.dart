import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:subspace/view/constant.dart';
import 'package:subspace/view/glitch.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100.0,
            ),
            GlithEffect(
              child: Text(
                "SubSpace",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.black,
                  backgroundColor: Colors.grey.shade50,
                    fontFamily: 'Acme-Regular',
                    letterSpacing: 2
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: LottieBuilder.asset('lottie/animation_ln8yez2a.json'),
              ),
            ),
             Center(child: Text(
               "Invest Your Time",
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 30,
                 color: Colors.black,
                 backgroundColor: Colors.grey.shade50,
                 fontFamily: 'Agdasima-Regular',
                 letterSpacing: 1
               ),
             ),),
            Center(
              child: Container(
                height: 150,
                child: LottieBuilder.asset('lottie/animation_ln8z6104.json'),
              ),
            ),
            Center(
              child: Text(
                "Made By Harsh",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
