class UsersController < ApplicationController
  before_action :require_is_user, only: [:edit, :update]

  def index
    @users = User.all

    # render json: users
    render :index
  end

  def show
    # Need to use instance variables for views!!
    @user = User.find(params[:id])
    
    # render json: user
    render :show
  end

  def new
    @user = User.new # empty/blank user
    render :new
  end
  
  def create
    @user = User.new(user_params)
    # sets attributes for columns, no password column

    if @user.save
      # login the user
      login!(@user) #method comes from application controller
      
      # redirect_to "/users/#{user.id}"
      redirect_to user_url(@user)
    else
      # render json: user.errors.full_messages, status: 422
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      # redirect_to "/users/#{user.id}"
      redirect_to user_url(@user)
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy

    # render json: @user
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :age, :political_affiliation, :password)
  end

  def require_is_user
    redirect_to users_url unless current_user.id == params[:id].to_i
  end

  # params hash
  # {
  #   user: {
  #     username: 'asdf',
  #     age: 12
  #   }
  # }
  
end
