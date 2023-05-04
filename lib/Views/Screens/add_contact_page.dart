import 'package:flutter/material.dart';

class add_contact_page extends StatefulWidget {
  const add_contact_page({Key? key}) : super(key: key);

  @override
  State<add_contact_page> createState() => _add_contact_pageState();
}

class _add_contact_pageState extends State<add_contact_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Info"),
        centerTitle: true,
      ),
      body: Stepper(
        onStepContinue: (){},
        onStepCancel: (){},
        steps: [
          Step(title: Text("Pick Image"), content: Stack(
            alignment: Alignment.bottomRight,
            children:[ CircleAvatar(
              radius: 60,
              child: Text("Pick Image"),
            ),
              Theme(data: ThemeData(
                useMaterial3: false,
              ),
              child: FloatingActionButton(onPressed: (){},child:
              Icon(Icons.add,color: Colors.white,),mini: true,),),
            ],
          ),),
        ],
      ),
    );
  }
}
