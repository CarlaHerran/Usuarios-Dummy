get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :index

end

get '/login' do
	erb :login
end

post '/login' do
	email = params[:email]
	password = params[:password]
	@user = User.authenticate(email, password)
	if @user
		session[:user_id] = @user.id
		redirect '/secret'
	else
		redirect '/'	
	end
end


get '/create_account' do 
	# Método para crear cuentas de ususario. Hay que mostrar un formulario para que ingresen los datos que quieran tener.
	erb :create_account
end

post '/create_account' do
	name = params[:name]
	email = params[:email]
	password = params[:password]
	@user = User.create(name: name, email: email, password: password)
	session[:user_id] = @user.id
	redirect '/secret'
end

get '/secret' do
	if session[:user_id]
		@user = User.find(session[:user_id])
		erb :secret
	else
		redirect '/login'
	end	
end

get '/logout' do
	session.clear
	redirect '/'
end

