package com.predicto.services;
import java.io.File;

import org.apache.commons.math.linear.RealMatrixImpl;

import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffLoader;

public class linear_regression {
public static void main(String args[]) throws Exception
{

	ArffLoader loader = new ArffLoader();
	  loader.setSource(new File("D:/Weka API/WebContent/WEB-INF/lib/new44.arff"));
	  Instances data = loader.getDataSet();//get instances object
		ArffLoader loader1 = new ArffLoader();
		  loader1.setSource(new File("D:/Weka API/WebContent/WEB-INF/lib/new45.arff"));
		  Instances data1 = loader1.getDataSet();//get instances object
	  double x[][]= new double[207][13];
	  double y[]=new double[207];
	  for (int i = 0; i < 207; i++) {
		    Instance instance = data.instance(i);
		    Instance instance1 = data1.instance(i);
		    
		    x[i]=instance.toDoubleArray();
		    y[i]=instance1.value(0);
		    System.out.print(x[i][0]+"  "+x[i][6]+"  ");
		    System.out.println(y[i]);
	
		

}


	RealMatrixImpl X=new RealMatrixImpl(x);
	
	RealMatrixImpl Y=new RealMatrixImpl(y);
	RealMatrixImpl X_transpose=(RealMatrixImpl) X.transpose();
	
	RealMatrixImpl XTX=(RealMatrixImpl) X_transpose.multiply(X);

	RealMatrixImpl XTX_inv=(RealMatrixImpl) XTX.inverse();
	RealMatrixImpl newterm=(RealMatrixImpl) X_transpose.multiply(Y);
	int truth=0;
	int fals=0;
	RealMatrixImpl result=(RealMatrixImpl) XTX_inv.multiply(newterm);
		for(int i=208;i<303;i++)
		{
		Instance instance = data.instance(i);
	    Instance instance1 = data1.instance(i);
	    
		double[] inp=new double[13];
		inp=instance.toDoubleArray();
	   
		double bal=(inp[0]*result.getEntry(0,0))+(inp[1]*result.getEntry(1,0))+(inp[2]*result.getEntry(2,0))+(inp[3]*result.getEntry(3,0))+(inp[4]*result.getEntry(4,0))+(inp[5]*result.getEntry(5,0))+(inp[6]*result.getEntry(6,0))+(inp[7]*result.getEntry(7,0))+(inp[8]*result.getEntry(8,0))+(inp[9]*result.getEntry(9,0))+(inp[10]*result.getEntry(10,0))+(inp[11]*result.getEntry(11,0))+(inp[12]*result.getEntry(12,0));
		System.out.println(instance1.value(0)+":   "+bal);
		if(bal>=1.30)
		{
			bal=2;
			if(instance1.value(0)==bal)
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
			bal=1;
			if(instance1.value(0)==bal)
			{
				truth+=1;
			}
			else
			{
				fals++;
			}
		}
		}
		System.out.println("true:"+truth+"false:"+fals);
		for(int k=0;k<result.getRowDimension();k++)
		{
			System.out.println(result.getEntry(k,0));
		}
	
}
public static void multiplication(int x[][], int y[][])
{
	int rows1= x.length;
	int cols1= x[0].length;
	int rows2= y.length;
	int cols2= y[0].length;
	if(cols1==rows2)
	{
		int z[][]= new int[rows1][cols2];
		for(int i=0;i<rows1;i++)
		{
			for(int j=0;j<cols2;j++)
			{
				for(int k=0; k<cols1;k++)
				{
					z[i][j]+=x[i][k]*y[k][j];
				}
			}
		}
		print(z);
		
	}
	else
	{
		System.out.println("not possible");
	}
}

public static void print(int x[][])
{
	System.out.println("rows= "+x.length);
	System.out.println("Cols= "+x[0].length);
	for (int i=0;i<x.length;i++)
	{
		for(int j=0;j<x[0].length;j++)
		{
			System.out.print(x[i][j]+" ");
		}
		System.out.println();
	}
}
}
