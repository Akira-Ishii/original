class TweetsController < ApplicationController
  
 require "twitter"

  
  def search
   
 
   
   
   if params[:q]
    @client = Twitter::REST::Client.new do |config|
           config.consumer_key = 'hoOxFTeWweT9aI5vXtJ1eLS8Q'
           config.consumer_secret = 'UbHjixrWz2zUxGLAZscoWlVZGs95GbBOa1WcIwn2dUfHh6fZYt'
           config.access_token = '2472156692-Q4jBr1CgPalNP9M7xBg2mI5NfzcQqlh1MRc0vbL'
           config.access_token_secret = 'MnCNeW2nLhvc8D7f6KaGDkgEWH9bbN5HJl5kky8QwYjdR'
    end
    
    if params[:pos]
    result_tweets = @client.search(params[:q] + " :)", 
                                   count: 100, 
                                   result_type: "recent",  
                                   exclude: "retweets", 
                                   since_id: 0)
                                   
    elsif params[:neg]
    result_tweets = @client.search(params[:q] + " :(", 
                                   count: 100, 
                                   result_type: "recent",  
                                   exclude: "retweets", 
                                   since_id: 0)     
    else
    result_tweets = @client.search(params[:q], 
                                   count: 100, 
                                   result_type: "recent",  
                                   exclude: "retweets", 
                                   since_id: 0)     
    end
    
    
    texts = []
    
    result_tweets.each do |t|
      texts << t.text
    end
     
    @texts = texts               
    
   words = []
   
   nm = Natto::MeCab.new 
   
   texts.each do |c|
    
    res = nm.parse(c)
    res.split("\n").each do |n|
     if n.include?("名詞")
      word = n.split("\t")[0]
      words << word
     end
     
    end
   end
   
   word_count = {}
   
   words.each do |key|
    word_count[key] ||= 1
    word_count[key] += 1
   end
    
   @words = word_count.sort_by { |word_count| word_count[1].to_i }.reverse 
   end
  end

  def show
  end

  private

end
