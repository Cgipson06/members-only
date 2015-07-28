class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
  end
  
  def create
		post = Post.new(post_params)
		post.author = current_user.name
		if post.save
			flash[:success] = "Post saved"
			redirect_to posts_path
		else
			render :new
		end
	end
  
  def index
    @posts = Post.all
  end
  
  
  private
    def logged_in_user
			unless logged_in?
				flash[:danger] = "Please log in"
				redirect_to login_url
			end
		end
        
        def post_params
          params.require(:post).permit(:author, :title, :body)
        end
          
end
