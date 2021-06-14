class UsersController < ApplicationController
  before_action :set_article, only:[:show, :edit, :update]
  
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
      session[:user_id] = @user.id
      flash[:notice] = "Welcome #{@user.username}. You successfully signed up."
      redirect_to articles_path
        
    else
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

  private 

  def set_article
	  @user = User.find(params[:id])
	end
  def user_params

    params.require(:user).permit(:username, :email, :password)
  end

end