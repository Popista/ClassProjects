package Lucene;



import org.apache.lucene.analysis.standard.StandardAnalyzer;

import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;

//import org.apache.lucene.document.IntPoint;
import org.apache.lucene.document.NumericDocValuesField;
import org.apache.lucene.document.StoredField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
//import org.apache.lucene.index.IndexableField;
//import org.apache.lucene.queries.function.valuesource.IntFieldSource;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.MatchAllDocsQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.SortField;//
//import org.apache.lucene.search.SortField.Type;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
//import org.apache.lucene.store.RAMDirectory;
//import org.apache.lucene.util.Version;
import org.json.JSONException;
import org.json.JSONObject;


//import java.awt.List;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
//import java.util.ArrayList;
import java.util.Scanner;
import java.util.TreeMap;
//import java.util.Vector;

public class LuceneIndex {
  public static void main(String[] args) throws IOException, ParseException {
    // 0. Specify the analyzer for tokenizing text.
    //    The same analyzer should be used for indexing and searching
    StandardAnalyzer analyzer = new StandardAnalyzer();
    // 1. create the index
    //Directory index = new RAMDirectory();
    Path path = Paths.get("./test");
    Directory index = FSDirectory.open(path);
    IndexWriterConfig config = new IndexWriterConfig(analyzer);
    //read the input file and build the index
    //Directory dir = new SimpleFSDirectory(new File("d://index"));
    //System.out.println("1 for build index 2 for get answer from index");
    int type;
    Scanner scanner = new Scanner(System.in);
    //type = scanner.nextInt();
    type =2;
    if(type==1)
    {
    	IndexWriter w = new IndexWriter(index, config);
    	try {
			TextReader(w);//read file and build index
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	w.close();
    	System.out.println("finish the building of csv");
    }
    //the following is using these index
    // 2. query
    String querystr = args.length > 0 ? args[0] : "nba";
    //Query q = NumericRangeQuery.newIntRange("followers_c", 0, 200, true, true);
    // the "title" arg specifies the default field to use
    // when no field is explicitly specified in the query.
     //Query q = new QueryParser("followers_c", analyzer).parse("[10 TO 23]");
    //Query q = IntPoint.newRangeQuery("followers_c", 0,100);
    Query q = new MatchAllDocsQuery();
    Query q2 = new QueryParser("text",analyzer).parse(querystr);
    Sort sort=new Sort(new SortField[] {SortField.FIELD_SCORE,new SortField("followers_c",SortField.Type.INT,true)});
  
    
    
    // 3. search
    int hitsPerPage = 100;//how many pages wants to show
    IndexReader reader = DirectoryReader.open(index);
    IndexSearcher searcher2 = new IndexSearcher(reader);
    TopScoreDocCollector collector = TopScoreDocCollector.create(hitsPerPage);
    
    searcher2.search(q2, collector);
    ScoreDoc[] hits = collector.topDocs().scoreDocs;
    
    IndexSearcher searcher = new IndexSearcher(reader);
    TopDocs num_hits = searcher.search(q2, 1664006, sort,true,true);
    
    
    // 4. display results
    //System.out.println("Found " + hits.length + " hits.");
   // System.out.println("Found " + num_hits.totalHits + " hits.");
    TreeMap<Integer,String> tree = new TreeMap<>(Collections.reverseOrder());
    for(int i=0;i<num_hits.totalHits;i++) {  //search my the populartiy
	      Document doc=reader.document(num_hits.scoreDocs[i].doc);  
	      //System.out.println(doc);  
	      
	      String str = doc.get("name")+("\n")+doc.get("text").replaceAll("\n", " ")+("\n")+doc.get("followers_c")+("\n")+doc.get("location").replaceAll("\n", " ")+("\n")+doc.get("time");
	      tree.put(Integer.parseInt(doc.get("followers_c")),str);
	      
	      //System.out.println(doc.get("followers_c") +"\t"+doc.get("name")+"\t"+doc.get("text") );
       }
   for (int i  : tree.keySet())
   {
	   //String output = tree.get(i).en;
	   //ByteBuffer byteBuffer = Charset.forName("UTF-8").encode(tree.get(i));
	   String text = tree.get(i);
	   byte[] byteText = text.getBytes(Charset.forName("UTF-8"));
	   //To get original string from byte.
	   String originalString= new String(byteText , "UTF-8");
	   //byte ptext[] = myString.getBytes(tree.get(i)); 
	   //String value = new String(ptext, "UTF-8"); 
	   //String str2 = new String(byteBuffer,'UTF-8');
	   System.out.println(originalString);
   }
    /*
    for(int i=0;i<10;++i) {
       int docId = hits[i].doc;
       Document d = searcher2.doc(docId);
      System.out.println((i + 1) + ". " + d.get("followers_c") + "\t   "+ d.get("name") + "\t   " + d.get("text"));
    }*/
    
    
    // reader can only be closed when there
    // is no need to access the documents any more.
    reader.close();
  }
//addDoc(w, name, followers_c,friends_c,text,time,hash_tag,location,id);String
  private static void addDoc(IndexWriter w, String name, String followers_c,String friends_c,String text,String time,String hash_tag,String location,String id) throws IOException {
    Document doc = new Document();
    doc.add(new TextField("name", name, Field.Store.YES));
    doc.add(new TextField("time", time, Field.Store.YES));
    int num = Integer.parseInt(followers_c);
    doc.add(new NumericDocValuesField("followers_c", num));
    doc.add(new StoredField("followers_c", num));
    doc.add(new TextField("friends_c", friends_c, Field.Store.YES));
    doc.add(new TextField("text", text, Field.Store.YES));
    doc.add(new TextField("hash_tag", hash_tag, Field.Store.YES));
    doc.add(new TextField("location", location, Field.Store.YES));
    doc.add(new StringField("id", id, Field.Store.YES));
    w.addDocument(doc);
  }
  private static void TextReader(IndexWriter w) throws IOException, JSONException
  {
	  
	  String filepath = "fetched_tweets.txt"; // 绝对路径或相对路径都可以，这里是绝对路径，写入文件时演示相对路径
	  //String filepath = "fetched_tweets.txt";
	  File file = new File(filepath); // 要读取以上路径的HotClick.txt文件
	  if (!file.exists()) 
	  {//判断文件目录的存在
		  System.out.println("The input file is not exisitng");
	      System.exit(0);
	  }
	  FileInputStream fileInputStream = null;
      fileInputStream = new FileInputStream(file);
      InputStreamReader reader = new InputStreamReader(fileInputStream,"UTF-8"); // 建立一个输入流对象reader
      BufferedReader br = new BufferedReader(reader); // 建立一个对象
      String json = "";
      json = br.readLine();
      //System.out.println(line);
      int round = 0;
      long startTime= System.currentTimeMillis();
      int limit = (1664006/10)*10;
      while (json != null&& round<= limit) 
      {
    	  round++;
    	//make sure the readline will not stop at \n
          while(!json.contains("timestamp_ms"))
          {
        	  json+=br.readLine();
          }
          if(!json.contains("delete"))
          {
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
          addDoc(w, name, followers_c,friends_c,text,time,hash_tag,location,id);
          }
          json = br.readLine(); // 一次读入一行数据
          //System.out.println(json);
      }
      long endtime = System.currentTimeMillis();
      System.out.println("running time:" +(endtime-startTime)/1000.0);
      System.out.println(round);
  }
	
 }
