class ContentsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :edit, :create, :update, :destroy]
  before_action :set_content, only: [:show, :edit, :update, :destroy]

  # GET /contents
  # GET /contents.json
  def index
    # 条件指定を可能にする
    # ただし、あらかじめ許可した内容以外は条件として指定できないようにする
    categories = ["top", "profile", "history", "products"]
    category = ""
    @contents = ""
    if params[:category].blank?
      @contents = Content.all.includes(:tags)
    else
      category = params[:category].to_s
      checked = false
      categories.each do |item| 
        if category == item
          checked = true
        end
      end
      if !checked
        category = ""
      end
      logger.debug("category=["+category+"]")
      @contents = Content.where(category: category).includes(:tags)
    end
    respond_to do |format|
      format.html { @contents }
      format.json { render json: @contents }
    end
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
  end

  # GET /contents/new
  def new
    @content = Content.new
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents
  # POST /contents.json
  def create
    @content = Content.new(content_params)

    respond_to do |format|
      if @content.save
        format.html { redirect_to @content, notice: 'Content was successfully created.' }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1
  # PATCH/PUT /contents/1.json
  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to @content, notice: 'Content was successfully updated.' }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to contents_url, notice: 'Content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(:content).permit(:title, :detail, :category, :tag_list, :when, :sequence)
    end
end
