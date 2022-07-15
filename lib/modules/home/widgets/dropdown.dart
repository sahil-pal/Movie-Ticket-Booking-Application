import 'package:bigboxo_application/config/themes/mytheme.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  
  late List<String> data;
  late String hint;
  late dynamic changeFn;
  late bool ignored;

  MyDropDown({required this.hint,required this.data,this.ignored = false,this.changeFn = null});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SizedBox(
        height: deviceSize.height*0.07,
        width: deviceSize.width*0.7,
        child : IgnorePointer(
          ignoring: ignored,
          child: DropdownButton(
            elevation: 0,
            isExpanded: true,
            underline: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.8,color: Colors.black)
              ),
            ),
            hint: Text(hint),
            items: data.map((String value){
              return DropdownMenuItem(
                alignment: Alignment.center,
                value: value,
                child: Container(
                  width: deviceSize.width*0.7,
                  color: Colors.blueGrey,
                  padding: const EdgeInsets.all(5),
                  child: Text(value),
                ),
              );
            }).toList(), 
            onChanged: (value){
              changeFn(value);
          }
      ),
        ),
    );
  }
}