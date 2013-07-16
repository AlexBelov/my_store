class ItemsController < ApplicationController

  before_filter :find_item,      only: [:show, :edit, :update, :destroy, :upvote]
  before_filter :check_if_admin, only: [:new, :edit, :create, :update, :destroy]

  def index
    @items = Item.all.order("votes_count DESC, price").limit(50)
  end

  def expensive
    @items = Item.where("price > 1000")
    render "index"
  end

  def show
    unless @item
      render text: "Page not found", status: 404
    end
  end

  def new
    @item = Item.new
  end

  def edit

  end

  def create
    #render text: params.inspect
    @item = Item.create(item_params)

    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render "new"
    end
  end

  def update
    @item.update_attributes(item_params)

    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render "edit"
    end
  end

  def destroy
    @item.destroy
    redirect_to action: "index"
  end

  def upvote
    @item.increment!(:votes_count)
    redirect_to action: :index
  end

  private

  def item_params
    params.require(:item).permit(:price, :name, :description, :weight)
  end

  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end

end
