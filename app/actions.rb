
##############
# CONTROLLER #
##############

helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end

get '/' do
    @finstagram_posts = FinstagramPost.order(created_at: :desc)
    erb(:index)
end

get '/signup' do        # if a user navigates to the path "/signup"
    @user = User.new    # set up an empty @user object
    erb(:signup)        # render "app/views/signup.erb"
end

get '/login' do        # if a user navigates to the path "/login"
    # @user = User.new    # set up an empty @user object
    erb(:login)        # render "app/views/signup.erb"
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
            # "User #{username} saved!"
            redirect to('/login')
        else
            erb(:signup)
    end
end

post '/login' do        # if a user navigates to the path "/login"
    username = params[:username]
    password = params[:password]

    # find user by username
    @user = User.find_by(username: username)

    # conditionals based on whether credentials match
    if @user && @user.authenticate(password)
        session[:user_id] = @user.id
        # "Success - user id #{session[:user_id]} is logged in!"
        redirect to('/')
    else
        @error_message = "Unable to log in. Check Username or Password."
        @username = username
        erb(:login)
    end
end

get '/logout' do
    session[:user_id] = nil
    # "Logout successful."
    redirect to('/')
end

get '/finstagram_posts/new' do
    @finstagram_post = FinstagramPost.new
    erb(:'finstagram_posts/new')
end

post '/finstagram_posts/new' do
    photo_url = params[:photo_url]

    # instantiate new FinstagramPost
    @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id })

    # if @post validates, save
    if @finstagram_post.save
        redirect(to('/'))
    else

        # if not, print error message
        erb(:'/finstagram_posts/new')
    end
end

get '/finstagram_posts/:id' do
    @finstagram_post = FinstagramPost.find(params[:id]) # find the finstagram post with the ID given in the URL
    erb(:'finstagram_posts/show') # render single post view
end

post '/comments' do
    finstagram_post_id = params[:finstagram_post_id]
    text = params[:text]

    new_comment = Comment.new({ user_id: current_user.id, finstagram_post_id: finstagram_post_id, text: text })
    new_comment.save
    
    redirect(back)

end

post '/likes' do
    finstagram_post_id = params[:finstagram_post_id]

    new_like = Like.new({ finstagram_post_id: finstagram_post_id, user_id: current_user.id })
    new_like.save

    redirect(back)
end

delete '/likes/:id' do
    like = Like.find(params[:id])
    like.destroy
    redirect(back)
end

delete '/comments/:id' do
    comment = Comment.find(params[:id])
    comment.destroy
    redirect(back)
end