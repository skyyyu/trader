class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @like = Like.new
    @search = @posts.ransack(params[:q])
    @posts = @search.result(distinct: true)
 
    @all_ranks = Post.find(Like.group(:post_id).where(created_at: Date.today.in_time_zone.all_day).order('count(post_id) desc').limit(3).pluck(:post_id))

    # like_array = []
    # Like.where(created_at: Date.yesterday.in_time_zone.all_day).each do |like|
    #   like_array.push(like.post_id)
    #   puts (like.post_id)
    # end
    # @like_array = like_array.group_by(&:itself).map{ |key, value| [key, value.count] }.to_h


    respond_to do |format| 
      format.html {render template: "posts/index"}
      format.json { render json: @new_post = Post.where('id > ?', params[:post][:id]) } # json形式でアクセスがあった場合は、params[:message][:id]よりも大きいidがないかMessageから検索して、@new_messageに代入する
   end
  end

  def timeline
    @test = 'test'
    @posts = Post.all
    @like = Like.new
    @search = @posts.ransack(params[:q])
    @posts = @search.result(distinct: true)
    #フォローしている人のidの一覧を取得

    @post_data = Post.where(user_id: current_user.id).group("date(created_at)").count

    array = current_user.follows.map{|follow| follow.followable_id}
    array.push(current_user.id)

    @posts = @posts.where(user_id: array)

   
    respond_to do |format| 
      format.html {render template: "posts/index"}
      format.json { render json: @new_post = Post.where(user_id: array).where('id > ?', params[:post][:id]) } # json形式でアクセスがあった場合は、params[:message][:id]よりも大きいidがないかMessageから検索して、@new_messageに代入する

    end

      
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @like = Like.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    puts "aaa"
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:date, :price, :profit, :news, :factor, :img, :title, :low, :high, :open, :close)
    end
end
