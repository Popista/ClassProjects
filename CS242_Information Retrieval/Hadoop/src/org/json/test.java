package org.json;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

import org.json.JSONObject;
public class test {
	  
	  
    public static void main(String[] args) throws IOException {  
        //解析字符串 
    	FileReader fr=new FileReader("/Users/yifeilai/Courses/IR/fetched_tweets.txt");
        BufferedReader br=new BufferedReader(fr);
        String line="";
        int i = 0;
        String test = "";
        while ((line=br.readLine())!=null && i < 1) {
            test = line;
            i++;
            //System.out.println(test);
        }
       
         
          
        //解析对象  
        System.out.println(test);
        JSONObject jsonObject = new JSONObject(test); 
        
        System.out.println(jsonObject.get("created_at"
        		+ "").toString());  
        br.close();
        fr.close();
    
    }  
	  
	
}
