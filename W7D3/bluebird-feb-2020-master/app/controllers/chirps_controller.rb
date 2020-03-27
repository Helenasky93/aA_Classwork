class ChirpsController < ApplicationController
  before_action :require_logged_in!

  def index
    @chirps = Chirp.where(author_id: params[:user_id])

    # render json: chirps
    render :index
  end

  def show
    chirp = Chirp.find(params[:id])

    render json: chirp
  end

  def new
    
  end
  
  def create
    @chirp = Chirp.new(chirp_params)
    @chirp.author_id = current_user.id

    if @chirp.save
      redirect_to user_chirps_url(@chirp.author_id)
    else
      flash.now[:errors] = @chirp.errors.full_messages
      render :new
    end
  end

  private

  def chirp_params
    params.require(:chirp).permit(:body)
  end
end
