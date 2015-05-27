class SessionsController < ApplicationController
  def create
    user = User.find_for_oauth(request.env['omniauth.auth'])
    if user
      session[:u] = user.session_token
      redirect_to root_path, notice: 'Signed in'
    else
      redirect_to root_path, notice: 'Unable to sign in'
    end
  end

  def error
    flash[:error] = 'Sign in with Twitter failed'
    redirect_to root_path
  end
end

