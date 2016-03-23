require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	@error = "something wrong!"
	erb :about
end

get '/visit' do
	erb :visit
end
get '/contacts' do 
	erb :contacts 
end

post '/visit' do
	@name   = params[:username]
	@phone  = params[:phone]
	@time   = params[:datetime]
	@master = params[:master]
	@color  = params[:color]
	hh =  {:username => 'Enter name',
		   :phone    => 'Enter phone',
		   :datetime => 'Enter date and time' 
	}
		@error = hh.select {|key, _ | params[key] == ""}.values.join(" , " )
			if @error != ""
				return erb :visit
			end
			f = File.open './public/users.txt', 'a'
		
	f.write "#{@name}, phone: #{@phone}, time: #{@time}, master: #{@master}, color: #{@color}"
	f.close
   # erb :visit
	erb "#{@name}, phone: #{@phone}, time: #{@time}, master: #{@master}, color: #{@color}"
end

post '/contacts' do

 #require 'pony'
    @mail   = params[:email]
	@text   = params[:text]
	hh = {:email => 'Enter email adress',
		  :text => 'Enter your text'}
		@error = hh.select {|key, _ | params[key] == ''}.values.join (" , ")
		if @error != ""
				return erb :contacts
			end

 Pony.mail(
  :name => params[:name],
  :mail => params[:mail],
  :body => params[:body],
  :to => 'a_lumbee@gmail.com',
  :subject => params[:name] + " has contacted you",
  :body => params[:message],
  :port => '587',
  :via => :smtp,
  :via_options => {
  :address              => 'smtp.gmail.com', 
    :port                 => '587', 
    :enable_starttls_auto => true, 
    :user_name            => 'lumbee', 
    :password             => 'p@55w0rd', 
    :authentication       => :plain, 
    :domain               => 'localhost.localdomain'
  })
     #redirect '/success' 

	f = File.open './public/users.txt', 'a'
	f.write "#{@mail}, #{@text}."
	f.close
	erb :contacts
end