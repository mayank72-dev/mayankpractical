import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mayankptactical/src/Style/colors.dart';

import '../Constants/appImages.dart';

customTextField(
    double width,
    TextEditingController controller,
    
    FormFieldValidator validator,
    FocusNode focusNode,
    String hintText,{double? height,  bool? obscureText , VoidCallback? onTap, String ? suffixIcon, int ?maxLength, bool ? readOnly,Color? cursorColor,Function(String?)? onSaved,String? prefixIcon,Function(String)?onChanged }) {
  return SizedBox(
    width: width,
    child: TextFormField(
        cursorColor: cursorColor ?? Colors.black,
        readOnly: readOnly??false,
        maxLength:maxLength ,
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        onSaved: onSaved,
        onChanged: onChanged,

        decoration: InputDecoration(
            focusColor: AppColors.grey,
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange,width: 4)),
            enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: AppColors.black,width: 4)),
            border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.black,width: 4) ),
            hintText: hintText,

           // prefixIcon :  Image.asset(prefixIcon??""),
            fillColor: AppColors.white,
  suffixIcon: null == suffixIcon ? null : InkWell( onTap: onTap,child: Image.asset(AppImages.down, height: 5,))
  )));
}