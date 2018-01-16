require 'digest'
require 'sinatra'
require 'sinatra/session'
require 'sqlite3'
require 'tilt/erb'
require 'pp'

# ==================== CONFIG SECTION
if /[\D]+/.match(ARGV[0])
  set :port, 4567
else
  if not ARGV[0].nil?
    set :port, ARGV[0].to_i
  else
    set :port, 4567
  end
end

set :app_file => __FILE__
set :bind => '0.0.0.0'
set :static => enable
set :views => "#{File.dirname(__FILE__)}/views"
set :public_folder => "#{File.dirname(__FILE__)}/assets"
# Enable sessions
enable :sessions
set :session_fail, '/login'
# Create session secret
o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
set :session_secret, (0...100).map { o[rand(o.length)] }.join

db = SQLite3::Database.open('todo.db')
db.execute("create table users(id int, name varchar(20), password varchar(64))")


=begin
puts 'Enter a first password: '
password = gets.chomp

encrypted_password = Digest::SHA256.hexdigest(password)
encrypted_password_with_salt = Digest::SHA256.hexdigest(password+'some_salt')

puts "First password: #{encrypted_password}, second password: #{encrypted_password_with_salt}"


puts 'Starting decrypting password...'
puts "First password: #{Digest::SHA256.digest(encrypted_password)}"
=end
