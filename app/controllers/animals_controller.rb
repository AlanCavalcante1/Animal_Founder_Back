class AnimalsController < ApplicationController
  before_action :set_animal, only: [:show, :update, :destroy]
  load_and_authorize_resource

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

  def animal_page
    
    page = params[:page].to_i - 1
    page = 0 if page < 0 
      
    animals_per_page = 15
    start = page * animals_per_page
    
    animals = Animal.where(status: "lost")
    animals_recent_add = animals.reverse
    animals_to_page = animals_recent_add.slice(start, animals_per_page)
    
    render json: {animals: animals_to_page}
  end

  def answer

    unless params[:message].present?
      return render json: {error: "A mensagem é obrigatória"}, status: 400
    end
    
    animal = Animal.find_by(id: params[:animal])
    unless animal.present?
      return render json: {error: "Animal não encontrado"}, status: 404
    end

    unless animal.status == 'lost'
      return render json: {error: "Animal não se encontra desaparecido"}, status: 400
    end

    answer = Answer.create!(user_id: current_user.id, animal_id: animal.id, message: params[:message])
    animal.update_attributes(status: 1)
    AnswerMailer.with(informant: current_user, animal: animal, message: params[:message], url: request.base_url).notice.deliver_now
    render json: {answer: answer}, status:201
  
  end

  def my_animals
    byebug
    animals = Animal.where(user_id: current_user.id)
    render json: {animals: animals}
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

    def answer_params
      params.permit(:message)
    end
end
