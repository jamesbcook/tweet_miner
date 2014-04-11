#!/usr/bin/env ruby

require 'pg'
require './database'
require 'tweetstream'

def build_db(db_name,table_name)
  @db = PGDatabase.new(db_name, 'localhost', 5432, 'postgres')
  @db.create_table(table_name,
                   id: 'serial PRIMARY KEY',
                   text: 'text',
                   username: 'text',
                   guid: 'bigint',
                   lang: 'text',
                   time_zone: 'text',
                   created_at: 'text')
  rescue => e
    puts e
end

def help
  fail ArgumentError, "#{$PROGRAM_NAME} <db_name> <table_name> <what_to_mine>\n"
end

def tweet_stream
  TweetStream.configure do |config|
    config.consumer_key = ''
    config.consumer_secret = ''
    config.oauth_token = ''
    config.oauth_token_secret = ''
    config.auth_method = :oauth
  end
  @client = TweetStream::Client.new
end

begin
  help unless ARGV.length == 3
  build_db(ARGV[0], ARGV[1])
  tweet_stream
  x = 0
  @client.track(ARGV[2]) do |status|
    begin
      @db.insert(text: status.text,
                 username: status.user.screen_name,
                 guid: status[:id],
                 lang: status.user.lang,
                 time_zone: status.user.time_zone,
                 created_at: status.created_at)
      # puts "[#{status.user.screen_name}] #{status.text}"
      print "Tweets Mined: #{x}\r"
      x += 1
    rescue => e
      puts e
    end
  end
end
