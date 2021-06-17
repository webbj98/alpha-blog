class UsersController < ApplicationController
  before_action :set_article, only:[:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
	before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def new 
    @user = User.new
  end

  def show
    # @user = User.find(params[:id])
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)

  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      print("got saved")
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.username}. You successfully signed up."
      redirect_to articles_path
        
    else
      print("didn't get saved")
      print(@user.errors.full_messages)
      render 'new'    
    
    end
  end

  def edit
    # @user = User.find(params[:id])

  end

  def update 
    # @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account  info was succcessfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account all associated articles deleted"
    redirect_to articles_path
  end
  private 

  def set_article
	  @user = User.find(params[:id])
	end
  def user_params

    params.require(:user).permit(:username, :email, :password)
  end

  private
  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own profile"
      redirect_to @user
    end
  end

end