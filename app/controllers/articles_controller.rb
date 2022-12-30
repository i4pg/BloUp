class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  # GET /articles or /articles.json
  def index
    @articles = if user_signed_in?
                  @liked = current_user.liked_articles
                  Article.includes(:author).where(author: current_user.friends).or(current_user.articles).order(created_at: :desc)
                else
                  Article.includes(:author).order(created_at: :desc)
                end
  end

  # GET /articles/1 or /articles/1.json
  def show
    @comments = @article.comments.order(created_at: :desc)
    @liked = current_user.liked_articles
  end

  # GET /articles/new
  def new
    @text_id = (Text.last&.id&.+ 1) || 1
    @article = current_user.articles.new
  end

  # GET /articles/new_image
  def new_image
    @image_id = (Image.last&.id&.+ 1) || 1
    @article = current_user.articles.new
  end

  # GET /articles/1/edit
  def edit; end

  def articleble
    case params[:article][:articleble_type]
    when 'Text'
      @text = Text.create
    when 'Image'
      @image = Image.create
    end
  end

  # POST /articles or /articles.json
  def create
    articleble

    @article = current_user.articles.create(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_path(@article), notice: 'Article was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    return unless current_user == @article.user

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_path(@article), notice: 'Article was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    return unless current_user == @article.user

    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_path, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:body, :user_id, :articleble_type, :articleble_id, :image, :link)
  end
end
