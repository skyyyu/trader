# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(:email => 'aaa@hoge.com', :password => 'asd123' ,:name =>'aaa')
user.save!

user = User.new(:email => 'bbb@hoge.com', :password => 'asd123' ,:name =>'bbb')
user.save!

user = User.new(:email => 'test2@test.com', :password => 'testtest' ,:name =>'test')
user.save!