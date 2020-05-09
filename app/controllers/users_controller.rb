class UsersController < ApplicationController

  def index
    @users = User.all
    @posts = Post.all
    @search = @users.ransack(params[:q])
    @posts_search = @posts.ransack(params[:q])
    @users = @search.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params) #user_paramsはPOSTデータをチェックするメソッド
   
    if @user.save
      flash[:success] = '新しいユーザーを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
     
    if current_user == @user
     
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        render :edit
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end   
     
    else
        redirect_to root_url
    end   
  end

  def follow
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    redirect_to user_path(@user)
  end
  #フォローする

  def unfollow
      @user = User.find(params[:user_id])
      current_user.stop_following(@user)
      redirect_to user_path(@user)
  end
  #フォローを外す


  def follow_list
    @user = User.find(params[:user_id])
  end
  #フォローしてる人の一覧ページ

  def follower_list
    @user = User.find(params[:user_id])
  end
  #フォロワーの一覧ページ

  private
 
  #ストロングパラメーター
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :introduce, :age, :sex, :address)
  end


end
