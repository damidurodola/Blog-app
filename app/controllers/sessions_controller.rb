class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:session][:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
    # If user's login doesn't work, send them back to the login form.
      flash.now[:danger] = "Your login details are incorrect.Try again"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path,  notice: "You have successfully logged out."
  end

end