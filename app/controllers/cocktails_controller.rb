class CocktailsController < ApplicationController
  before_action :set_cocktails, only: [:show, :edit, :update]

  def index
    @cocktails = Cocktail.all
  end

  def show
    @doses = Dose.where(cocktail_id: @cocktail.id)
  end

  def new
    ingredients = Ingredient.all

    @ingredients = []
    ingredients.each do |ingredient|
      @ingredients << ingredient.name
    end
    @ingredients.sort!

    @cocktail = Cocktail.new
    @cocktail.doses.build
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      @ingredient = Ingredient.find_by_name(params["cocktail"]["ingredients"]["name"])
      @dose = Dose.new(description: params["cocktail"]["doses_attributes"]["0"]["description"], cocktail: @cocktail, ingredient: @ingredient)
    else
      render :new
    end

    if @dose.save!
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @cocktail.update(cocktail_params)

    redirect_to cocktails_path
  end


  private

  def cocktail_params
    params.require(:cocktail).permit(:id, :name)
  end

  def set_cocktails
    @cocktail = Cocktail.find(params[:id])
  end

end
