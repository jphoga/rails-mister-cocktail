require 'byebug'

class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = Dose.where(cocktail_id: @cocktail.id)
  end

  def new
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

  private

  def cocktail_params
    params.require(:cocktail).permit(:id, :name)
  end

end
