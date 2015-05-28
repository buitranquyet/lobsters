class AddTweetIdToStories < ActiveRecord::Migration
  def change
    add_column :stories, :tweet_id, :string
  end
end
