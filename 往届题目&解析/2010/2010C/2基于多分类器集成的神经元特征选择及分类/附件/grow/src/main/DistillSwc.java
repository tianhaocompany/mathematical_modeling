package main;

import java.io.*;
import java.text.*;
import java.util.*;
import swcparts.*;
import java.math.*;

public class DistillSwc {
  public static String INPUT_FILE="";
  public static String OUTPUT_DIR="";
  
  
  public static SwcNeuron distillSwc(){
	  SwcNeuron neuron=new SwcNeuron();
	  neuron.InitSwcNeuron(INPUT_FILE);
	  return neuron;
  }
  
}
