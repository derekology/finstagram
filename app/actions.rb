get '/' do
    @finstagram_posts = FinstagramPost.order(created_at: :desc)
    erb(:index)
end

get '/signup' do        # if a user navigates to the path "/signup"
    @user = User.new    # set up an empty @user object
    erb(:signup)        # render "app/views/signup.erb"
end

post '/signup' do
    
    # grab form submission values
    email = params[:email]
    avatar_url = params[:avatar_url]
    username = params[:username]
    password = params[:password]

        # instantiate the User
        @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password})

        # If validation passes, save the User
        if @user.save
            "User #{username} saved!"
        else
            erb(:signup)
    end
end