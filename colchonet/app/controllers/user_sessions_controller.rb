class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new(session)
  end
  def create
    @user_session = UserSession.new(session,params[:user_session])

    if @user_session.authenticate!
      redirect_to root_path, notice: "Logado com sucesso"
    else
      render :new
    end

  end
  def destroy
# Ainda não :-)
  end

  def current_user
    User.find(@session[:user_id])
  end
  def user_signed_in?
    @session[:user_id].present?
  end
end