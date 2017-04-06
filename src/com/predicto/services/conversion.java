package com.predicto.services;

public class conversion {
public  static String convert_calories_run(String run)
{
	Float f=Float.parseFloat(run);
	f=(float)((f*906)/10.0584);//906 for 
	
	return String.valueOf(f);
}
public static String convert_calories_walk(String walk)
{
	Float f=Float.parseFloat(walk);
	f=(float)((f*452)/6.43738);//452 for 6.43738 kms
	
	return String.valueOf(f);
}
public static String convert_calories_cycle(String cycle)
{
	Float f=Float.parseFloat(cycle);
	f=(float)((f*552)/7.775);//552 calories for 7.775 kms
	
	return String.valueOf(f);
}
public static String convert_calories_work(String work)
{
	Float f=Float.parseFloat(work);
	f=(float)((f*550)/30);//550 calories for 30 min
	
	return String.valueOf(f);
}
}
