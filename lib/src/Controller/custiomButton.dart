import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///  custombutton
customButton(VoidCallback onTap,Color color,String title,{double ?height, Color ?textColor,double? fontWeight,double ? width} ) {
  return InkWell(onTap: onTap,
    child: Container(height: height ?? ScreenUtil().setHeight(50),
        width: width ?? ScreenUtil().setWidth(double.infinity),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(title, style: TextStyle(
          color: textColor ?? Colors.white, fontWeight: FontWeight.w400,),))),);
}
