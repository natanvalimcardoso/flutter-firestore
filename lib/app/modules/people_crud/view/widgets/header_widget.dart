import 'package:flutter/material.dart';
    
class HeaderWidget extends StatelessWidget {

  const HeaderWidget({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
            height: 100,
            width: double.infinity,
            child: Card(
              elevation: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo-standard.png'),
                      ),
                    ),
                  ),
                  const Text(
                    '(Lista das pessoas)',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}