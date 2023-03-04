import 'package:flutter/material.dart';

Widget buildListNewsItem()=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Column(

    children:
    [
      Row(
        children:
        [
          Image(
            width: 90,
            height: 90,
            image:NetworkImage(
              'https://upload.wikimedia.org/wikipedia/commons/c/c1/Lionel_Messi_20180626.jpg',
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                  'messi its a7sn la3b fltare5 ;dfjas;dlmn.,cxcmkl;ajpdfsajcnx,.zcniowadyhaslkac',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF182952),
                  ),
                ),
                Text(
                  '2 april 2002',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
);

Widget defaultTextFormField({
  required TextEditingController controller,
  required String labelText,
  required IconData preffixIcon,
  IconData? suffixIcon,
  required TextInputType type,
  bool obscureText=false,
  VoidCallback? function,
  Function ,
})=>TextFormField(
    controller: controller,
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    labelText: labelText,
    prefixIcon: Icon(
        preffixIcon,
    ),
    suffixIcon: IconButton(
        onPressed: function,
      icon: Icon(
          suffixIcon,
      ),
    ),
  ),
  onTap: Function,
  keyboardType: type,
  obscureText: obscureText,

    );