package Lucene;
import java.io.File; 
import java.io.FileReader; 
import java.io.Reader;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date; 
import org.apache.lucene.analysis.Analyzer; 
import org.apache.lucene.analysis.standard.StandardAnalyzer; 
import org.apache.lucene.document.Document; 
import org.apache.lucene.document.Field;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory; 
/** 
* This class demonstrate the process of creating index with Lucene 
* for text files 
*/ 
public class test { 
     public static void main(String[] args) throws Exception{ 
	     //indexDir is the directory that hosts Lucene's index files 
	     Analyzer luceneAnalyzer = new StandardAnalyzer();
	     Path p = Paths.get("./test");
	     Directory indexDir = FSDirectory.open(p);
	     //dataDir is the directory that hosts the text files that to be indexed 
	     File   dataDir  = new File("."); 
	    
	     File[] dataFiles  = dataDir.listFiles();
	     IndexWriterConfig config = new IndexWriterConfig(luceneAnalyzer);
	     IndexWriter indexWriter = new IndexWriter(indexDir,config); 
	     long startTime = new Date().getTime(); 
	     for(int i = 0; i < dataFiles.length; i++){ 
	          if(dataFiles[i].isFile() && dataFiles[i].getName().endsWith(".txt")){
	               System.out.println("Indexing file " + dataFiles[i].getCanonicalPath()); 
	               Document document = new Document(); 
	               Reader txtReader = new FileReader(dataFiles[i]); 
	               char t = (char)txtReader.read();
	               System.out.println(dataFiles[i].getCanonicalPath());
	               document.add(new Field("path",dataFiles[i].getCanonicalPath(),TextField.TYPE_STORED)); 
	               document.add(new Field("contents",txtReader,TextField.TYPE_NOT_STORED)); 
	               indexWriter.addDocument(document); 
	          } 
	     }
	     indexWriter.close(); 
	     long endTime = new Date().getTime(); 
	         
	     System.out.println("It takes " + (endTime - startTime) 
	         + " milliseconds to create index for the files in directory "
	         + dataDir.getPath());        
	     } 
}