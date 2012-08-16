class SessionsController < ApplicationController
  def create
    if admin = Admin.authenticate(params[:nickname],params[:password])
      session[:admin_id] = admin.id
      redirect_to root_path
    else
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
