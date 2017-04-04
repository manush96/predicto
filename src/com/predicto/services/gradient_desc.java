package com.predicto.services;


import java.io.File;
import java.io.IOException;


import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffLoader;

public class gradient_desc {
	public static void main(String args[]) throws IOException
	{
		double [][] x= load_x();
		double [] y=load_y();
		
		/*double [][] x = {{100,3,1},{200,6,2},{150,4,2}};
		double [] y = {500,400,400};*/
		
		double [] theta= load_theta();
		int f=0;
		int count=0;
		while(f==0)
		{
			double temp[]=new double[14];
			
			for(int j=0;j<14;j++)
			{
				//System.out.println(sigma(x,y,theta,j));
				temp[j]=theta[j]-((0.05/x.length)*(sigma(x,y,theta,j)));
			}
			double[] delta=new double[14];
			for(int i=0;i<14;i++)
			{
				delta[i]=Math.abs(theta[i]-temp[i]);
				System.out.print(temp[i]+" ");
				
			}
			double sum=0;
			for(int i=0;i<14;i++)
			{
				sum+=delta[i];
			}
			//System.out.println(sum);
			count++;
			if(count>29)
				f=1;
			if(sum<1E-10)
			{
				f=1;
			}
				//System.out.println("\n");
			theta=temp;
			
			
		}
		get_index(theta);

	}
	
	public static double sigma(double[][] x,double[] y,double[] theta,int j)
	{
		double sigm=0;
		
		for(int i=0;i<x.length;i++)
		{
		//	System.out.println(cost(theta,x[i],y[i],j));
			sigm=sigm+cost(theta,x[i],y[i],j);
		}
		return sigm;
	}
	public static void get_index(double[] theta) throws IOException
	{
		double f_try=1.45;
		double b_try=1.5;
		double final_index=1.5;
		boolean forward=true;
		boolean backward=true;
		int check_high=0;
		while(true)
		{
			if(forward==true)
			{

				int d[]= check_accuracy(theta,f_try+=0.05);
				System.out.println(f_try+"---"+d[0]+"  "+ d[1]);	
				if(d[0]>=check_high)
				{
					check_high=d[0];
					final_index=f_try;
				}
				else
				{
					forward=false;
					System.out.println("Now Back...");
				}
			}
			else if(backward==true)
			{
				int d[]= check_accuracy(theta, b_try-=0.05);
				System.out.println(b_try+"---"+d[0]+"  "+ d[1]+"  ");
		
				if(d[0]>=check_high)
				{
					check_high=d[0];
					final_index=b_try;
				}
				else
				{
					backward=false;
				}
			}
			else
			{
				break;
			}
		}
		System.out.println(final_index);
		
	}
	public static int[] check_accuracy(double[] theta, double test) throws IOException
	{
		ArffLoader loader = new ArffLoader();
		  loader.setSource(new File("C:/Users/manush96/Downloads/input.arff"));

			ArffLoader loader1 = new ArffLoader();
			  loader1.setSource(new File("C:/Users/manush96/Downloads/output.arff"));
			  Instances data1 = loader1.getDataSet();//get instances object
		
		  Instances data = loader.getDataSet();//get instances object
		  double x[][]= new double[303-208][13];
		  double y[][]= new double[303-208][14];
		  double[] z=new double[data1.numInstances()];
		  int count=0;
		  for (int i = 208; i <303; i++) {
			    Instance instance = data.instance(i);
			    x[count]=instance.toDoubleArray();
			    y[count][0]=1;
			    for(int j = 1; j <=13; j++)
			    {
			    	y[count][j]=x[count][j-1];
			    }
			    
			    Instance instance1=data1.instance(i);
			    z[count]=instance1.value(0);
			    count++;
			    
			}
		  int truth = 0;
		  int fals=0;
		  int[] result=new int[2];
		  System.out.println(y.length);
		  for(int i=0;i<y.length;i++)
		  {
			  double y1=hypo(theta,y[i]);
			  //System.out.println(z[i]+":"+y1);
			  
			if(y1>=test)
			{
				y1=2;
				if(z[i]==y1)
				{
					truth++;
				}
				else
				{
					fals++;
				}
			}
			else
			{
				y1=1;
				if(z[i]==y1)
				{
					truth+=1;
				}
				else
				{
					fals++;
				}
			}
			
			}
		  result[0]=truth;
		  result[1]=fals;
		  return result;
	}
	public static double cost(double[] theta,double[] xi,double yi,int j)
	{
		
		double hyp=hypo(theta,xi);
		//System.out.println(yi);
		/**/
		double c1=hyp-yi;
		//System.out.println(c1);
		double cost=c1*xi[j];
		return cost;
	}
	public static double hypo(double[] theta, double[] xi)
	{
		double sum=0.0;
		for(int i=0;i<theta.length;i++)
		{
			sum+= theta[i]*xi[i];
		}
		return sum;
	}
	public static double[] load_theta()
	{
		double[] yje=new double[14];
		for(int i=0;i<14;i++)
		{
			yje[i]=0;
		}
		return yje;
	}
	public static double[][] load_x() throws IOException
	{
		ArffLoader loader = new ArffLoader();
		  loader.setSource(new File("C:/Users/manush96/Downloads/input.arff"));
		  Instances data = loader.getDataSet();//get instances object
		  double x[][]= new double[207][13];
		  double y[][]= new double[207][14];
		  for (int i = 0; i < 207; i++) {
			    Instance instance = data.instance(i);
			    x[i]=instance.toDoubleArray();
			    y[i][0]=1;
			    for(int j = 1; j <=13; j++)
			    {
			    	y[i][j]=x[i][j-1];
			    }
			    
//			    System.out.print(instance.toString(0)+" ");
//			    System.out.print(instance.stringValue(1)+" ");
//			    System.out.print(instance.toString(2)+" ");
//			    System.out.print(instance.stringValue(3)+" ");
//			    System.out.print(instance.stringValue(4)+" ");
//			    System.out.print(instance.toString(5)+" ");
//			    System.out.print(instance.stringValue(6)+" ");
//			    System.out.println(instance.stringValue(7)+" ");
			    //System.out.println(y[i][0]+"  "+y[i][1]+"   "+ x[i][0]);
			    //get Attribute 0 as String
			}
		  int max = 1;
		  
		  for (int j = 0; j< y[0].length; j++)
		  {
			  if(y[0][j] > max || -y[0][j] < -max)
			  {
				  y = normalize(y,j);
			  }
		  }
		  /*for (int i = 0; i< y.length; i++)
		  {
			  for (int j = 0; j< y[i].length; j++)
			  {
				  System.out.print(y[i][j]+" ");
			  }
			  System.out.println();
		  }*/
			  
		  return y;
	}
	public static double[][] normalize(double[][] y,int j)
	{
		double max = 0 ,min =0, sum = 0;
		double v;
		for(int i=0; i< y.length; i++)
		{
			v = y[i][j];
			sum+=v;
			if(v > max)
				max = v;
			if(v < min)
				min = v;
			
		}
		double mean = sum/y.length;
		double range = max - min;
		for(int i=0; i< y.length; i++)
		{
			y[i][j] = (y[i][j]-mean)/range;
		}
		return y;
	}
	public static double[] load_y() throws IOException
	{
		ArffLoader loader = new ArffLoader();
		  loader.setSource(new File("C:/Users/manush96/Downloads/output.arff"));
		  Instances data = loader.getDataSet();//get instances object
		  double x[]= new double[207];
		  for (int i = 0; i < 207; i++) {
			    Instance instance = data.instance(i);
			    x[i]=instance.value(0);
			    
			    
//			    System.out.print(instance.toString(0)+" ");
//			    System.out.print(instance.stringValue(1)+" ");
//			    System.out.print(instance.toString(2)+" ");
//			    System.out.print(instance.stringValue(3)+" ");
//			    System.out.print(instance.stringValue(4)+" ");
//			    System.out.print(instance.toString(5)+" ");
//			    System.out.print(instance.stringValue(6)+" ");
//			    System.out.println(instance.stringValue(7)+" ");
			    //System.out.println(y[i][0]+"  "+y[i][1]+"   "+ x[i][0]);
			    //get Attribute 0 as String
			}
		  return x;
	}
}



