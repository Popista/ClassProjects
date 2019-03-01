package Lucene;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.Date;

import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.NumericDocValuesField;
import org.apache.lucene.document.SortedDocValuesField;
import org.apache.lucene.document.StoredField;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.LeafReaderContext;
import org.apache.lucene.index.NumericDocValues;
import org.apache.lucene.index.Term;
import org.apache.lucene.queries.CustomScoreProvider;
import org.apache.lucene.queries.CustomScoreQuery;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.BytesRef;

class RecencyBoostingQuery extends CustomScoreQuery{  
    
    private double multiplier;  
      
    private int today;  
      
    private int maxDaysAgo;  
      
    private String dayField;  
      
    static final int MSEC_PER_DAY=1000*2600*24;  
      
    public RecencyBoostingQuery(Query subQuery,double multiplier,int maxDaysAgo,String dayField) {  
        super(subQuery);  
        // TODO Auto-generated constructor stub  
        today=(int) (new Date().getTime()/MSEC_PER_DAY);  
        this.multiplier=multiplier;  
        this.maxDaysAgo=maxDaysAgo;  
        this.dayField=dayField;  
    }  
  
    private class RecencyBooster extends CustomScoreProvider{  
          
        private NumericDocValues publishDay;    
          
        public RecencyBooster(LeafReaderContext context) throws IOException {  
            super(context);  
            // TODO Auto-generated constructor stub  
            publishDay=context.reader().getNumericDocValues(dayField);  
        }  
          
        public float customScore(int doc,float subQueryScore,float valSrcScore) throws IOException {  
            int docId=publishDay.advance(doc);  
            int daysAgo=(int) (today-publishDay.longValue());  
            if(daysAgo<maxDaysAgo) {  
                float boost=(float) (multiplier*(maxDaysAgo-daysAgo)/maxDaysAgo);  
                return (float) (subQueryScore*(1.0+boost));  
            }else {  
                return subQueryScore;  
            }  
        }  
    }  
      
    public CustomScoreProvider getCustomScoreProvider(LeafReaderContext context) throws IOException {  
        return new RecencyBooster(context);  
    }
}
public class query {
	
	 public static void main (String [] args) throws Exception {
		 Directory dir=FSDirectory.open(Paths.get("lucene_indexes"));  
	       IndexWriterConfig config=new IndexWriterConfig();  
	       IndexWriter writer = new IndexWriter(dir,config);  
	       Document document = new Document();  
	       Document document1 = new Document();  
	       Document document2 = new Document();  
	       Document document3 = new Document();  
	       Document document4 = new Document();  
	       document.add(new NumericDocValuesField("pubdate",201006));  
	       document.add(new StoredField("pubdate", 201006));  
	       document.add(new StringField("title","Spring In Action",Field.Store.YES));  
	       document.add(new SortedDocValuesField("title",new BytesRef("Spring In Action".getBytes())));  
	       document1.add(new NumericDocValuesField("pubdate",201007));  
	       document1.add(new StringField("title","Lucene In Action",Field.Store.YES));  
	       document1.add(new SortedDocValuesField("title",new BytesRef("Lucene In Action".getBytes())));  
	       document1.add(new StoredField("pubdate", 201007));  
	       document2.add(new NumericDocValuesField("pubdate",201008));  
	       document2.add(new StringField("title","Solr In Action",Field.Store.YES));  
	       document2.add(new SortedDocValuesField("title",new BytesRef("Solr In Action".getBytes())));  
	       document2.add(new StoredField("pubdate", 201008));  
	       document3.add(new NumericDocValuesField("pubdate",201009));  
	       document3.add(new StringField("title","Hadoop In Action",Field.Store.YES));  
	       document3.add(new SortedDocValuesField("title",new BytesRef("Hadoop In Action".getBytes())));  
	       document3.add(new StoredField("pubdate", 201009));  
	       document4.add(new NumericDocValuesField("pubdate",201010));  
	       document4.add(new StringField("title","Spark In Action",Field.Store.YES));  
	       document4.add(new SortedDocValuesField("title",new BytesRef("Spark In Action".getBytes())));  
	       document4.add(new StoredField("pubdate", 201010));  
	       writer.addDocument(document);  
	       writer.addDocument(document1);  
	       writer.addDocument(document2);  
	       writer.addDocument(document3);  
	       writer.addDocument(document4);  
	       writer.close();
	         
	       IndexReader reader=DirectoryReader.open(dir);  
	       IndexSearcher searcher=new IndexSearcher(reader);  
	       Query q1=new MatchAllDocsQuery();
	       Query q2 = new RecencyBoostingQuery(q1,2.0, 2*365,"pubdata");
	            
	       Sort sort=new Sort(new SortField[] {SortField.FIELD_SCORE,new SortField("pubdate",SortField.Type.INT,true)});  
	       TopDocs hits=searcher.search(q1, 15, sort, true, true);  
	       System.out.println(hits.totalHits);  
	         for(int i=0;i<hits.totalHits;i++) {  
		      Document doc=reader.document(hits.scoreDocs[i].doc);  
		      System.out.println(doc);  
		      System.out.println(doc.getField("title").stringValue()+":"+doc.get("pubdate")+":"+hits.scoreDocs[i].score);
	         }
	 }
}