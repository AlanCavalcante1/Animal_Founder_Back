class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :update, :destroy]

  rescue_from CanCan::AccessDenied do |exception|
    render json: {message: "Permissao Negada, você não tem permissão a esse acesso"}, status: 403
  end

  # GET /animals
  def index
    @animals = Animal.all

    render json: @animals
  end

  # GET /animals/1
  def show
    render json: @animal
  end

  # POST /animals
  def create
    
    @animal = Animal.new(animal_params)

    if @animal.save
      render json: @animal, status: :created, location: @animal
    else
      render json: @animal.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /animals/1
  def update
    if @animal.update(edit_params)
      render json: @animal
    else
      render json: @animal.errors, status: :unprocessable_entity
    end
  end

  # DELETE /animals/1
  def destroy
    @animal.destroy
  end

  def page
    page = params[:page].to_i - 1
    animals_per_page = 15
    start = page * animals_per_page
    
    animals = Animal.where(status: "lost")
    animals_recent_add = animals.reverse
    animals_to_page = animals_recent_add.slice(start, animals_per_page)
    
    render json: {animals: animals_to_page}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_animal
      @animal = Animal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def animal_params
      params.permit(:photo, :name, :age, :description, :city, :state, :user_id)
    end

    def edit_params
      params.permit(:photo, :name, :age, :description, :city, :state, :status)
    end
end
