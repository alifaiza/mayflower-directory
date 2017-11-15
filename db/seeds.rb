# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# This is how we are making the admin, an admin. Add with the same format if you would like to make a new admin.
#user = User.create! :email => 'admin@admin.com', :password => 'password', :password_confirmation => 'password', :admin =>true

require 'aws-sdk'
require 'csv'
 
 csv_data = File.read('MayflowerDirectory1.csv')
 csv = CSV.parse(csv_data, :headers => true)
 csv.each do |row|
     row = row.to_hash.with_indifferent_access
     bob = row.to_hash.symbolize_keys
     prof = Profile.create!(bob)
     s3 = Aws::S3::Resource.new(
      access_key_id: ENV['AWS_ACCESS_KEY'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_DEFAULT_REGION'])
     link = s3.bucket(ENV['AWS_BUCKET_NAME']).object('images agnew, dan.png').public_url
     prof.remote_avatar_url = open(Net::HTTP.get(URI.parse(link)))
     #Rails.root.join("https://s3.us-east-2.amazonaws.com/mayflower-data/images/Agnew%2C+Dan.png").open
     prof.save!
     #U.avatar_url = 'https://s3.us-east-2.amazonaws.com/mayflower-data/images/Agnew%2C+Dan.png'
     #U.save!
 end

csv_data = File.read('MayflowerEmailPw.csv')
 csv = CSV.parse(csv_data, :headers => true)
 csv.each do |row|
     row = row.to_hash.with_indifferent_access
     bob = row.to_hash.symbolize_keys
     User.create!(bob)
 end

#Profile.create!(:first_name=>"Yetter", :last_name=>"Bob")
