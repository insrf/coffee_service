class PairUsersController < ApplicationController
  before_action :find_pair_user, only: %i[show edit update destroy]

  def index
    @pair_users = PairUser.includes(:user1, :user2)
  end

  def show
  end

  def new
    @pair_user = PairUser.new
  end

  def edit
  end

  def create
    @pair_user = PairUser.new(pair_user_params)

    if @pair_user.save
      redirect_to @pair_user, notice: 'Your pair_user successfully created.'
    else
      render :new
    end
  end

  def update
    if @pair_user.update(pair_user_params)
      redirect_to pair_users_path
    else
      render :edit
    end
  end

  def destroy
    @pair_user.destroy
    redirect_to pair_users_path
  end

  private

  def pair_user_params
    params.require(:pair_user).permit(:user1_id, :user2_id)
  end

  def find_pair_user
    @pair_user = PairUser.find(params[:id])
  end
end
