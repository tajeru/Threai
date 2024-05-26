class UsersController < ApplicationController
  before_action :redirect_root, except: [:new, :login_form, :login, :create]

  def new
    @user = User.new
  end

  def create
    @password = params[:password]
    @re_password = params[:password_confirmation]
    @name = params[:name]

    if @password == @re_password

    @user = User.new(name: @name, password: @password, password_confirmation: @re_password)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/posts/index"
    else
      flash[:error_message] = "この名前は既に使われています。"
      render "new"
    end

  else
    flash[:error_message] = "パスワードが一致しません"
    render "new"
  end
  end

  def login_form
  end

  def login
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/posts/index"
    else
      flash[:error_message] = "メールアドレスまたはパスワードが間違っています。"
      render ("/users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to "/"
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def redirect_root
    if @current_user.nil?
      redirect_to("/")
    end
  end
end