package org.apache.hadoop.examples;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.List;
 
import org.apache.hadoop.conf.Configuration;
import org.json.JSONException;
import org.json.JSONObject;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;

 
public class indexing {
  public static int doc = 0;
  public static class TokenizerMapper 
       extends Mapper<Object, Text, Text, Text>{
 
    private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();
    private Text index = new Text();
    private int position = 0;
    
    private String stopWords[] = {"rt","a","i","b","c","d","e", "about", "an", "above", "across", 
    		"after", "afterwards", "again", "against", "all", "almost", 
    		"alone", "along", "already", "also","although","always","am",
    		"among", "amongst", "amoungst", "amount",  "an", "and", "another", 
    		"any","anyhow","anyone","anything","anyway", "anywhere", "are", 
    		"around", "as",  "at", "back","be","became", "because","become",
    		"becomes", "becoming", "been", "before", "beforehand", "behind", 
    		"being", "below", "beside", "besides", "between", "beyond", "bill", 
    		"both", "bottom","but", "by", "call", "can", "cannot", "cant", "co", 
    		"con", "could", "couldnt", "cry", "de", "describe", "detail", "do",
    		"done", "down", "due", "during", "each", "eg", "eight", "either", 
    		"eleven","else", "elsewhere", "empty", "enough", "etc", "even",
    		"ever", "every", "everyone", "everything", "everywhere", "except", 
    		"few", "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly", "forty", "found", "four", "from", "front", "full", "further", "get", "give", "go", "had", "has", "hasnt", "have", "he", "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his", "how", "however", "hundred", "ie", "if", "in", "inc", "indeed", "interest", "into", "is", "it", "its", "itself", "keep", "last", "latter", "latterly", "least", "less", "ltd", "made", "many", "may", "me", "meanwhile", "might", "mill", "mine", "more", "moreover", "most", "mostly", "move", "much", "must", "my", "myself", "name", "namely", "neither", "never", "nevertheless", "next", "nine", "no", "nobody", "none", "noone", "nor", "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto", "or", "other", "others", "otherwise", "our", "ours", "ourselves", "out", "over", "own","part", "per", "perhaps", "please", "put", "rather", "re", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she", "should", "show", "side", "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something", "sometime", "sometimes", "somewhere", "still", "such", "system", "take", "ten", "than", "that", "the", "their", "them", "themselves", "then", "thence", "there", "thereafter", "thereby", "therefore", "therein", "thereupon", "these", "they", "thickv", "thin", "third", "this", "those", "though", "three", "through", "throughout", "thru", "thus", "to", "together", "too", "top", "toward", "towards", "twelve", "twenty", "two", "un", "under", "until", "up", "upon", "us", "very", "via", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever", "where", "whereafter", "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "whither", "who", "whoever", "whole", "whom", "whose", "why", "will", "with", "within", "without", "would", "yet", "you", "your", "yours", "yourself", "yourselves", "the"};
    String json = "";
    List<String> tempList = Arrays.asList(stopWords);
    public void map(Object key, Text value, Context context
                    ) throws IOException, InterruptedException {
      json += value.toString();
      if(!json.contains("timestamp_ms"))
      {
    	  return;
      }
      if(!json.contains("delete")){
    	  JSONObject jsonOb1= new JSONObject(json);// it means data is {}
          JSONObject json_user = (JSONObject)jsonOb1.getJSONObject("user");//lawyer
          JSONObject json_entity = (JSONObject)jsonOb1.getJSONObject("entities");//lawyer
          String hash_tag = json_entity.get("hashtags").toString();
          String location = json_user.get("location").toString();
          String name = json_user.get("screen_name").toString();
          String followers_c =  json_user.get("followers_count").toString();
          String friends_c =  json_user.get("friends_count").toString();
          String time = jsonOb1.get("created_at").toString();
          String text = jsonOb1.get("text").toString();
          String id = jsonOb1.get("id").toString();
          
          Pattern pattern = Pattern.compile("^[0-9]*$");
  		  Pattern pattern1 = Pattern.compile("(https?|ftp|file)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]");
  		  Pattern pattern2 = Pattern.compile("^[A-Za-z0-9]+$");
          StringTokenizer itr1 = new StringTokenizer(location);
          String inputText = "";

          while (itr1.hasMoreTokens()) {
        	  String temp = itr1.nextToken();
        	  Matcher m1 = pattern1.matcher(temp);
  			  if(!m1.matches()){
  				temp = temp.replaceAll("[[\\p{P}\\p{S}]&&[^._-]]", "");
  				Matcher m = pattern.matcher(temp);
  				Matcher m2 = pattern2.matcher(temp);
  				if( m.matches() || temp.length() == 1 || !m2.matches() ){ 
  			    	continue;
  			    }
  				inputText += temp + " ";
  			  }
  			  else{
  				inputText += temp + " ";
  			  }
          }
          //text = text.replaceAll("[[\\p{P}\\p{S}]&&[^_-]]" , " ");
          
          StringTokenizer itr = new StringTokenizer(inputText);
          doc++;
          System.out.println(doc);
          position = 0;
          while (itr.hasMoreTokens()) {
        	String t = itr.nextToken();
        	//System.out.println(t.length());
        	t = t.toLowerCase();
        	if(tempList.contains(t)){
        		continue;
        	}
        	position++;
        	index.set(String.valueOf(doc) + ":" + String.valueOf(position));
            word.set(t);
            context.write(word, index);
          }
      }
      json = "";
      
    }
  }
 
  public static class IntSumReducer 
       extends Reducer<Text,Text,Text,Text> {
    private Text result = new Text();
 
    public void reduce(Text key, Iterable<Text> values, 
                       Context context
                       ) throws IOException, InterruptedException {
      int sum = 0;
      HashMap<String, Integer> map = new HashMap<String, Integer>();
      String tmp;
      String numindoc = "";
      for (Text val : values) {
    	
    	tmp = val.toString();
    	//System.out.println(tmp);
    	numindoc += tmp + ";";
    	//System.out.println(numindoc);
    	String a = tmp.substring(0, tmp.indexOf(":"));
    	if(!map.containsKey(a)){
    		map.put(a, 1);
    	}
    	else{
    		int n = map.get(a);
    		System.out.println(n);
    		map.put(a, ++n);
    	}
        sum++;
      }
      String res = "TF:" + String.valueOf(sum) + ";";
      res += "DF:";
      for (String i : map.keySet()) {
      	res += i + ":" +String.valueOf(map.get(i)) + ";";
      	
      }
      res += "I:";
      res += numindoc;
      result.set(res);
      context.write(key, result);
    }
  }
 
  public static void main(String[] args) throws Exception {
	long startTime=System.currentTimeMillis();
    Configuration conf = new Configuration();
    String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
    if (otherArgs.length != 2) {
      System.err.println("Usage: wordcount <in> <out>");
      System.exit(2);
    }
    Job job = new Job(conf, "word count");
    job.setJarByClass(indexing.class);
    job.setMapperClass(TokenizerMapper.class);
    //job.setCombinerClass(IntSumReducer.class);
    job.setReducerClass(IntSumReducer.class);
    
    job.setMapOutputKeyClass(Text.class);
    job.setMapOutputValueClass(Text.class);
    
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(Text.class);
    FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
    FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
    long endTime=System.currentTimeMillis();
    long interval = (endTime-startTime) * 1000;
    System.out.println((interval) + "s");   
  }
}
