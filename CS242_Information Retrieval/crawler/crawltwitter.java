package crawler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.RateLimitStatus;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;
import org.json.JSONArray;  
import org.json.JSONObject; 
/**
 * 
 * @author coding-guru.com
 *
 */
public class crawltwitter {
	private int x = 0;
	ConfigurationBuilder cb = new ConfigurationBuilder();
	Twitter twitter;
	ArrayList<Status> tweets;
 
	crawltwitter() {
		cb.setDebugEnabled(true).setOAuthConsumerKey("UUyBdt8hMkmRGxyDqxlYbmxBm")
				.setOAuthConsumerSecret("dnl2NfOwhDTQCh9pPiRTCGuPmXKHB0hiXPtr57mVEywndEi3Gy")
				.setOAuthAccessToken("958796477786017792-EIDCBH4xqhaRfa1WKKnXODU1c8yZnC2")
				.setOAuthAccessTokenSecret("6pEKDUImWUJWUiWZPSvYAJ6PF8Hr7N28oFVP5elc1L2OU");
		twitter = new TwitterFactory(cb.build()).getInstance();
		tweets = new ArrayList<Status>();
	}
	private void handleRateLimit(RateLimitStatus rateLimitStatus) {
	    //throws NPE here sometimes so I guess it is because rateLimitStatus can be null and add this condition
	    if (rateLimitStatus != null) {
	        int remaining = rateLimitStatus.getRemaining();
	        int resetTime = rateLimitStatus.getSecondsUntilReset();
	        int sleep = 0;
	        if (remaining == 0) {
	            sleep = resetTime + 1; //adding 1 more seconds
	        } else {
	            sleep = (resetTime / remaining) + 1; //adding 1 more seconds
	        }

	        try {
	            Thread.sleep(sleep * 1000 > 0 ? sleep * 1000 : 0);
	        } catch (InterruptedException e) {
	            e.printStackTrace();
	        }
	    }
	}
 
	public void getTweets(String tag, int numberOfTweets, int queryCount) {
		Query query = new Query(tag);
		long lastID = Long.MAX_VALUE;
 
		while (tweets.size() < numberOfTweets) {
			if (numberOfTweets - tweets.size() > 100)
				query.setCount(queryCount);
			else
				query.setCount(numberOfTweets - tweets.size());
			try {
				QueryResult result = twitter.search(query);
				System.out.println(result.getRateLimitStatus());
				handleRateLimit(result.getRateLimitStatus());
				tweets.addAll(result.getTweets());
				System.out.println("Gathered " + tweets.size() + " tweets" + "\n");
				for (Status t : tweets) {
					if (t.getId() < lastID)
						lastID = t.getId();
				}
			}
 
			catch (TwitterException te) {
				System.out.println("Couldn't connect: " + te);
			}
			;
			query.setMaxId(lastID - 1);
		}
	}
 
	public void writeTweets() {
		FileWR writer = new FileWR("Tweets3");
		if(x==0){
			try {
				writer.writeFile("S#,Location,Date, User, Message \n");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		int tmp = 0;
		for (int i = 0; i < tweets.size(); i++) {
			Status t = (Status) tweets.get(i);
			System.out.println(t.getHashtagEntities().toString());
			
			String user = t.getUser().getScreenName();
			String msg = t.getText();
			
			Date d = t.getCreatedAt();
			Calendar cal = Calendar.getInstance();
			cal.setTime(d);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH);
			int day = cal.get(Calendar.DAY_OF_MONTH);
			tmp = 0;
			try {
				tmp = x + i;
				writer.writeFile(tmp + "," + t.getUser().getLocation() + "," + month + " - " + day + " - " + year
						+ ", USER: " + user + " , wrote: " + msg + "\n");
			} catch (IOException e) {
				e.printStackTrace();
			}
			
 
		}
		x = tmp;
		writer.close();
	}
 
	public static void main(String[] args) throws Exception {
		for(int i=0;i<1;i++){
			crawltwitter t = new crawltwitter();
			t.getTweets("#nba", 10000, 1000);
			t.writeTweets();
		}
	}
}