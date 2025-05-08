class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new  
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: "更新が完了しました"
    else
      render :edit, alert: "更新に失敗しました"
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.user = current_user

    if @prototype.save
      redirect_to root_path, notice: "投稿が完了しました"
    else
      render :new
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end
  
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
