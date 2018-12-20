require 'pp'

class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy, :like]

  # GET /dogs
  # GET /dogs.json
  def index    
    @limit = (params[:limit] ||= "5").to_i
    @page = (params[:page] ||= "1").to_i
        
    # get dogs by requests sort
    @dogs = Dog.get_dogs(params[:order_by]).page(page: @page, limit: @limit)   

    #calc total pages
    @total_pages = Dog.total_pages(limit: @limit)

    #get total dogs
    @total_dogs = Dog.all.count()

    # add some dogs as slides
    @slides = Dog.all.limit(6)
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit 
    if !@editable
      redirect_to action: "show", id: @dog.id
    end
  end

  # POST /dogs/like.json
  def like
    # if not current_user's dog
    if !@editable
      respond_to do |format|
        # increase likes by 1  
        @like = @dog.likes.create()

        if @like.save
            format.json {render json: @like, status: :ok}
        else          
            format.json {render json: @like.errors, status: :unprocessable_entity}
        end
      end
    else
      format.json { head :unauthorized }
    end
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)

    # set owner
    @dog.user_id = current_user.id

    respond_to do |format|
      if @dog.save
        @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update        
    if @editable
      respond_to do |format|      
        if @dog.update(dog_params)
          @dog.images.attach(params[:dog][:image]) if params[:dog][:image].present?

          format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
          format.json { render :show, status: :ok, location: @dog }
        else
          format.html { render :edit }
          format.json { render json: @dog.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { redirect_to action: "show", id: @dog.id }
      format.json { head :unauthorized }
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    if @editable
      @dog.destroy
      respond_to do |format|
        format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to action: "show", id: @dog.id }
      format.json { head :unauthorized }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      # set dog ref
      @dog = Dog.find(params[:id])

      # flip editable flag
      @editable = current_user ? current_user.id == @dog.user_id : false      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :description, :images)
    end
end
