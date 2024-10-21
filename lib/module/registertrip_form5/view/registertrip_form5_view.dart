
import 'package:bragasapps1/core.dart';
import 'package:flutter/material.dart';
import '../controller/registertrip_form5_controller.dart';

class RegistertripForm5View extends StatefulWidget {
  const RegistertripForm5View({Key? key}) : super(key: key);

  Widget build(context, bragas2conttroller controller) {
  controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("REGISTER TRIP FORM",style: TextStyle(fontWeight: FontWeight.bold,),),
        backgroundColor:  Colors.yellow,
        actions: const [],
        ),
        body: SingleChildScrollView(
         padding: EdgeInsets.all(20.0),
        child:Card(
            margin: const EdgeInsets.all(10.0),
            
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
              children: [
              
                QTextField(
                label: "Name",
                validator: Validator.required,
                // value: null,
                onChanged: (value) {
                controller.name = value;
              
                },),
              
              
                 QTextField(
                label: "Address",
                validator: Validator.required,
                // value: null,
                onChanged: (value) {
                controller.address = value;
              
                },),
              
              
              
                  QDropdownField(
                  label: "Gender",
                  validator: Validator.required,
                  items: [
                    {
                      "label": "Male",
                      "value": "Male",
                    },
                    {
                      "label": "Female",
                      "value": "Female",
                    }
                  ],
                  onChanged: (value, label) {
                    controller.gender = value;
                  },
                ),
              
                 QTextField(
                  label: "Phone",
                  validator: Validator.required,
                  // value: null,
                  onChanged: (value) {
                    controller.phone = int.tryParse(value)?? 0;
                  },
                ),
              
                QDropdownField(
                  label: "Package",
                  validator: Validator.required,
                  items: const[
                    {
                      "value": "Trip 1 RM 100",
                      "label": "Trip 1",
                    },
                    {
                      "value": "Trip 2 RM 300",
                      "label": "Trip 2",
                    },
                     {
                      "value": "Trip 3 RM 300",
                      "label": "Trip 3",
                    },
                     {
                      "value": "Trip 4 RM 300",
                      "label": "Trip 4",
                    },
                     {
                      "value": "Trip 5 RM 300",
                      "label": "Trip 5",
                    }
              
                  ],
                  onChanged: (value, label) {
                    controller.package = value;
                  },
                ),
              
                   QDropdownField(
                  label: "status",
                  validator: Validator.required,
                  items: const [
                    {
                      "label": "Pending",
                      "value": "Pending",
                    },
                   
                  ],
                  onChanged: (value, label) {
                    controller.status = value;
                  },
                ),
              
                
              
                Card(
                  color:  Colors.yellow, // Set the background color of the card
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        2.0, // Set the width of the card
                    height: 150, // Set the height of the card
                    child: Padding(
                      padding: EdgeInsets.all(10), // Add padding inside the card
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Bank account: Maybank",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "No ACCOUNT: 9802328924042",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Amount:",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "package Type",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              
                QImagePicker(
                  label: "Resit",
                  validator: Validator.required,
                  // value: null,
                  onChanged: (value) {
                    controller.resit = value;
                  },
                ),

                ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                ),
          
               onPressed: () => controller.dosave(),
              
                child: const Text("Save"),
                ),
              
              ],
              
              
              
              ),
            ),
        ),
    
      ),
  //     bottomNavigationBar: Container(
  // height: 40,
  // width:30,
  
  // child: ElevatedButton(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: Colors.blueGrey,
  //   ),
  //   onPressed: () => controller.dosave(),
  //   child: const Text("Save"),
  // ),
  //     ),
    );
  }

  @override
  State<RegistertripForm5View> createState() => bragas2conttroller();
}
    