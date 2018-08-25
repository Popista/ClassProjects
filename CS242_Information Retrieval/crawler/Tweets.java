package crawler;

import twitter4j.*;
import twitter4j.auth.AccessToken;
import twitter4j.conf.ConfigurationBuilder;

import java.util.List;
import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class Tweets {
	public static void main(String[] args) throws IOException {
	    BufferedReader br =new BufferedReader(new InputStreamReader(System.in));
	        try {
	       //Establish Connection to Twitter App
	        	
	            ConfigurationBuilder cb = new ConfigurationBuilder();
	            cb.setJSONStoreEnabled(true);
	            TwitterFactory twitterFactory =  new TwitterFactory(cb.build());
	        	Twitter twitter = twitterFactory.getInstance();
	            String accesssecret="6pEKDUImWUJWUiWZPSvYAJ6PF8Hr7N28oFVP5elc1L2OU";
	    		String consumerkey="UUyBdt8hMkmRGxyDqxlYbmxBm";
	    		String consumersecret="dnl2NfOwhDTQCh9pPiRTCGuPmXKHB0hiXPtr57mVEywndEi3Gy";
	    		String accessTokenStr = "958796477786017792-EIDCBH4xqhaRfa1WKKnXODU1c8yZnC2";
	            twitter.setOAuthConsumer(consumerkey, consumersecret);
	            AccessToken accessToken = new AccessToken(accessTokenStr,
	            		accesssecret);
	            twitter.setOAuthAccessToken(accessToken);
	        //////
	            ArrayList<String> JsonTweets =new ArrayList<String>();
	            Query query = new Query("money");
	            query.setCount(100);
	            query.setSince("2018-01-01");
	            query.setUntil("2018-02-01");
	             QueryResult result = twitter.search(query);
	             List<Status> resulted_tweets = result.getTweets();
	              for(Status tweet :resulted_tweets)
	              {
	                String json = TwitterObjectFactory.getRawJSON(tweet);
	                System.out.println(json);
	                //JsonTweets.add(json);
	              }
	              
	              //System.out.println((Arrays.toString(JsonTweets.toArray())));


	        }
	            catch (Exception e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }}
}
