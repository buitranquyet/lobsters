require 'csv'
require "uri"

desc 'Import ideas from csv '
task :import_data, [:file_name] => :environment do |task, args|
  user = User.first
  tag = Tag.first
  CSV.open(args[:file_name]).each do |row|
    story = Story.new(title: row.first.titleize, description: row.first, user_id: user.id, tags_a: [tag.tag])
    story.save
  end
end

task twitterbot: :environment do
  client = Twitter::REST::Client.new do |config|
    config.consumer_key    = ENV['TWITTER_KEY']
    config.consumer_secret = ENV['TWITTER_SECRET']
  end

  client.search("#musklevel", result_type: "recent").each do |tweet|
    content = tweet.text.gsub(/[#@]\w+/, '').strip
    url = URI.extract(content, /http(s)?/).first
    content = content.gsub(url.to_s, '') if url

    username = tweet.user.screen_name
    tag = Tag.first
    user = User.find_by_username(username)
    description = "#{content} (via [Twitter](https://twitter.com/#{username}/status/#{tweet.id}))"
    if user && !Story.find_by(user_id: user.id, tweet_id: tweet.id)
      story = Story.new(user_id: user.id, url: url, title: content, description: description, tweet_id: tweet.id, tags_a: [tag.tag])
      story.save
      puts "created #{tweet.id} - #{content} - #{username}"
    end
  end
end
