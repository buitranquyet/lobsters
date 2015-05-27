require 'csv'
desc 'Import ideas from csv '
task :import_data, [:file_name] => :environment do |task, args|
  user = User.first
  tag = Tag.first
  CSV.open(args[:file_name]).each do |row|
    story = Story.new(title: row.first.titleize, description: row.first, user_id: user.id, tags_a: [tag.tag])
    story.save
  end
end

