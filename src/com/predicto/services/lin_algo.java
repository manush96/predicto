package com.predicto.services;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import org.apache.commons.math.linear.RealMatrix;
import org.apache.commons.math.linear.RealMatrixImpl;
import org.jblas.DoubleMatrix;
import org.jblas.Solve;

import com.sun.scenario.effect.impl.sw.sse.SSEBlend_SRC_OUTPeer;

import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffLoader;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Normalize;

public class lin_algo {
	public static RealMatrixImpl result=new RealMatrixImpl();
public static RealMatrixImpl train() throws Exception
{

	ArffLoader loader = new ArffLoader();
	String path= System.getProperty("user.dir");
	  loader.setSource(new File(path+"/others/data_4442.arff"));
	  Instances data = loader.getDataSet();//get instances object
		ArffLoader loader1 = new ArffLoader();
		Normalize filter=new Normalize();
		filter.setInputFormat(data);
		Instances dataset=Filter.useFilter(data,filter);
		data=dataset;
		  loader1.setSource(new File(path+"/others/data_2.arff"));
		  Instances data1 = loader1.getDataSet();//get instances object
	  double x[][]= new double[2350][13];
	  double y[]=new double[2350];
	  for (int i = 0; i < 2350; i++) 
	  {
		    Instance instance = data.instance(i);
		    Instance instance1 = data1.instance(i);
		    
		    x[i]=instance.toDoubleArray();
		    
		    y[i]=instance1.value(0);
	
}
int max=1;
int min=999;
	/*for (int j = 0; j< x[0].length; j++)
	  {
		  if(x[0][j] > max || -x[0][j] < -max)
		  {
			  x = normalize(x,j);
		  }
	  }*/


	RealMatrixImpl X=new RealMatrixImpl(x);
	
	RealMatrixImpl Y=new RealMatrixImpl(y);
	RealMatrixImpl X_transpose=(RealMatrixImpl) X.transpose();
	
	RealMatrixImpl XTX=(RealMatrixImpl) X_transpose.multiply(X);

	RealMatrixImpl XTX_inv=(RealMatrixImpl) XTX.inverse();
	RealMatrixImpl newterm=(RealMatrixImpl) X_transpose.multiply(Y);
	result=(RealMatrixImpl) XTX_inv.multiply(newterm);
	return result;
}
public static double test() throws Exception
{
		ArffLoader loader = new ArffLoader();
		String path= System.getProperty("user.dir");
		loader.setSource(new File(path+"/others/data_4442.arff"));
		Instances data = loader.getDataSet();//get instances object
		ArffLoader loader1 = new ArffLoader();
		Normalize filter=new Normalize();
		filter.setInputFormat(data);
		Instances dataset=Filter.useFilter(data,filter);
		data=dataset;
		loader1.setSource(new File(path+"/others/data_2.arff"));
		Instances data1 = loader1.getDataSet();//get instances object

	int truth=0;
	int fals=0;
	double[] ones=new double[2561-2201];
	int cnt=0;
	double[] twos=new double[2561-2201];
	double[] threes=new double[2561-2201];

	ArrayList<Integer> l1=new ArrayList();
	for(int i=2351;i<2561;i++)
	{
	Instance instance = data.instance(i);
    Instance instance1 = data1.instance(i);
    
		double[] inp=new double[13];
		inp=instance.toDoubleArray();
	
		double bal=(inp[0]*result.getEntry(0,0))+(inp[1]*result.getEntry(1,0))+(inp[2]*result.getEntry(2,0))+(inp[3]*result.getEntry(3,0))+(inp[4]*result.getEntry(4,0))+(inp[5]*result.getEntry(5,0))+(inp[6]*result.getEntry(6,0))+(inp[7]*result.getEntry(7,0))+(inp[8]*result.getEntry(8,0))+(inp[9]*result.getEntry(9,0))+(inp[10]*result.getEntry(10,0))+(inp[11]*result.getEntry(11,0))+(inp[12]*result.getEntry(12,0))+(inp[13]*result.getEntry(13,0));
		if(instance1.value(0)==1)
			System.out.println(instance1.value(0)+":   "+bal);
		if(bal>1.55)
		{
			bal=2;
			if(instance1.value(0)==bal)
				truth++;
			else
				fals++;
				
		}
		else
		{
			bal=1;
			if(instance1.value(0)==bal)
				truth++;
			else
				fals++;

		}
	
	}
	System.out.println("true"+truth+" false:"+fals);
	double tr=truth+fals;
	double ty=(double)(truth/tr);
	return ty*100;
}
public double predict(double[] d)
{
	double sum=0;
	
	for(int i=0;i<d.length;i++)
	{
		sum+=d[i]*result.getEntry(i,0);
	}
	return sum;
	
}
}

