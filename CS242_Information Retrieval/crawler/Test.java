package crawler;
import java.util.*;
import twitter4j.*;
import twitter4j.conf.*;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
public class Test {
	

	public static void main(String[] a) throws IOException {
		FileWriter filewriter = new FileWriter("test.txt");
	    ConfigurationBuilder cb = new ConfigurationBuilder();
	    cb.setOAuthConsumerKey("UUyBdt8hMkmRGxyDqxlYbmxBm");
	    cb.setOAuthConsumerSecret("dnl2NfOwhDTQCh9pPiRTCGuPmXKHB0hiXPtr57mVEywndEi3Gy");
	    cb.setOAuthAccessToken("958796477786017792-EIDCBH4xqhaRfa1WKKnXODU1c8yZnC2");
	    cb.setOAuthAccessTokenSecret("6pEKDUImWUJWUiWZPSvYAJ6PF8Hr7N28oFVP5elc1L2OU");

	    Twitter twitter = new TwitterFactory(cb.build()).getInstance();

	    int pageno = 1;
	    String user = "cnn";
	    List statuses = new ArrayList();

	    while (true) {

	      try {

	        int size = statuses.size(); 
	        Paging page = new Paging(1, 100);
	        statuses.addAll(twitter.getUserTimeline(user, page));
	        if (statuses.size() == size)
	          break;
	      }
	      catch(TwitterException e) {

	        e.printStackTrace();
	      }
	    }
		filewriter.write(Arrays.toString(statuses.toArray()));
	    //System.out.println(Arrays.toString(statuses.toArray()));
	    System.out.println("Total: "+statuses.size());
	}
}
