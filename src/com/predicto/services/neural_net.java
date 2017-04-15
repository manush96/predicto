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
public class neural_net{
	public static String train () throws Exception{
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
		
		
		
		MultilayerPerceptron mlp = new MultilayerPerceptron();
		//Setting Parameters
		mlp.setLearningRate(0.005);
		mlp.setMomentum(0.2);
		mlp.setTrainingTime(2000);
		mlp.setHiddenLayers("6");;
		mlp.buildClassifier(data);
		
		return mlp.toString();
	}

	public static double test() throws Exception
	{
		ArffLoader loader = new ArffLoader();
		String path= System.getProperty("user.dir");

		loader.setSource(new File(path+"/others/data_4445.arff"));
		Instances dataset = loader.getDataSet();//get instances object
	
		double d[][]=new double [dataset.numInstances()][14];
		int true1=0;
		int false1=0;
		for (int i = 2362 ; i <= dataset.numInstances() - 1; i++) {
		    Instance instance = dataset.instance(i);
		    d[i]=instance.toDoubleArray();
		    
		    double x= -0.5005374333107243+
		    		0.6279028628732346*d[i][0]+
		    	    -0.1622406859674661*d[i][1]+
		    	    -0.42690543046315205*d[i][2]+
		    	    0.3657015538862433*d[i][3]+
		    	    -0.36053089577579817*d[i][4]+
		    	    0.224259590386114*d[i][5]+
		    	    0.611684501353883*d[i][6]+
		    	    0.34842811461734985*d[i][7]+
		    	   0.4219177025839987*d[i][8]+
		    	   0.3911546763725724*d[i][9]+
		    	  0.033286885230066066*d[i][10]+
		    	   -0.2431427099956879*d[i][11]+
		    	   0.36832175519815735*d[i][12]+
		    	   0.17055327317535926*d[i][13];
		    
		    System.out.println(x + "    " + d[i][14]);
		    if((x<1.052 && d[i][14]==1)||(x>=1.051 && d[i][14]==2))
		    {
		    	true1++;
		    }
		    else
		    {
		    	false1++;
		    }
		    
	
		}
		System.out.println("True:"+true1 +"     False:"+false1);
		double lk=true1+false1;
		double tr=(double)true1/lk;
		return tr*100;
	}
	public static double[] predict(double d[]) throws Exception
	{
		
		    double x= -0.5005374333107243+
		    		0.6279028628732346*d[0]+
		    	    -0.1622406859674661*d[1]+
		    	    -0.42690543046315205*d[2]+
		    	    0.3657015538862433*d[3]+
		    	    -0.36053089577579817*d[4]+
		    	    0.224259590386114*d[5]+
		    	    0.611684501353883*d[6]+
		    	    0.34842811461734985*d[7]+
		    	   0.4219177025839987*d[8]+
		    	   0.3911546763725724*d[9]+
		    	  0.033286885230066066*d[10]+
		    	   -0.2431427099956879*d[11]+
		    	   0.36832175519815735*d[12]+
		    	   0.17055327317535926*d[13];
		    //total = 5.27
		    int clas=0;
		    
		   if(x<1.052)
		   {
			   clas=1;
		   }
		   else{
			   clas=2;
	
		}
	double[] ret=new double[3];
	ret[0]=x;
	ret[1]=clas;
	ret[2]=1.052;
	return ret;
	}
}

