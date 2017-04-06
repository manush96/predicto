package com.predicto.services;


import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffLoader;
import weka.core.converters.ConverterUtils.DataSource;
import weka.datagenerators.Test;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Normalize;

import java.io.File;
import java.io.IOException;

import weka.classifiers.functions.LinearRegression;
import weka.classifiers.functions.MultilayerPerceptron;
//import weka.classifiers.functions.SMOreg;
public class lin_weka{
	public static String train() throws Exception{
		//load dataset
		String path= System.getProperty("user.dir");
		DataSource source = new DataSource(path+"/others/data_4445.arff");
		Instances dataset = source.getDataSet();
		//set class index to the last attribute
		dataset.setClassIndex(dataset.numAttributes()-1);
		Normalize filter = new Normalize();
		filter.setInputFormat(dataset);
		Instances data = Filter.useFilter(dataset, filter);
		data.setClassIndex(data.numAttributes()-1);
		
			
		//build model
		LinearRegression lr = new LinearRegression();
		lr.buildClassifier(dataset);
		//output model
		return lr.toString();
	}
	public static double test() throws Exception
	{
		ArffLoader loader = new ArffLoader();
		String path= System.getProperty("user.dir");
		loader.setSource(new File(path+"/others/data_4445.arff"));
		Instances data = loader.getDataSet();//get instances object
		double d[][]=new double [data.numInstances()][14];
		int true1=0;
		int false1=0;
		for (int i = 2362 ; i <= data.numInstances() - 1; i++) {
		    Instance instance = data.instance(i);
		    d[i]=instance.toDoubleArray();
		    double x= -0.0039 * d[i][0] +
		    	      0.005 * d[i][1] +
		    	      0.0018 * d[i][4] +
		    	      0.0005 * d[i][5] +
		    	     -0.003 * d[i][6] +
		    	      0.0026 * d[i][7] +
		    	      0.0001 * d[i][8] +
		    	      0.0007 * d[i][9] +
		    	      1.0491;
		    
		    System.out.println(x + "    " + d[i][14]);
		    if((x<1.6 && d[i][14]==1)||(x>=1.6 && d[i][14]==2))
		    {
		    	true1++;
		    }
		    else
		    {
		    	false1++;
		    }
		    
	
		}
		double h1=(true1+false1);
		double per=((double)true1/h1)*100;
		System.out.println(per+"ytrrr"+true1+"fals"+false1);
		return per;
	}
	public static double[] predict(double[] d) throws Exception
	{
		    double x= -0.0039 * d[0] +
		    	      0.005 * d[1] +
		    	      0.0018 * d[4] +
		    	      0.0005 * d[5] +
		    	     -0.003 * d[6] +
		    	      0.0026 * d[7] +
		    	      0.0001 * d[8] +
		    	      0.0007 * d[9] +
		    	      1.0491;
		    
		    
		    
		    double[] pred=new double[2];
		if(x>1.6)
		{
			pred[0]=2.0;
			pred[1]=x;
		}
		else
		{
			pred[0]=1.0;
			pred[1]=x;
		}
		return pred;
			
	}
}

