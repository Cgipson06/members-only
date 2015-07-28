class SessionsController < ApplicationController
  
  def new
  end
  
def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = 'Thank you for signing in!'
      log_in(user)
      redirect_to '/index'        
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  
  def destroy
    log_out
    redirect_to '/index'
  end

  

end
