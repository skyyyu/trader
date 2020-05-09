class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_search

  # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!

  # deviseコントローラーにストロングパラメータを追加する          
  before_action :configure_permitted_parameters, if: :devise_controller?
  def after_sign_in_path_for(resource)
    mypage_path(resource)
  end

  def after_sign_out_path_for resource
    new_user_session_url
  end 


  def set_search
    @posts = Post.all
    @search = @posts.ransack(params[:q])
    @posts = @search.result(distinct: true)
  end

  def set_graph
    @data = {'2019-06-01' => 100, '2019-06-02' => 200, '2019-06-03' => 150}
  end
  


  protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :image])
  end
  
end
