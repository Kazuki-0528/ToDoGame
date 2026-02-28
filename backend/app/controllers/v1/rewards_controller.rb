class V1::RewardsController < ApplicationController
  def create
    reward = Reward.new(reward_params)
    if reward.save
      render json: reward, status: :created
    else
      if reward.errors.present?
        render json: { error_msg: reward.errors.full_messages }, status: :unprocessable_entity
      else
        render json: reward.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    reward = Reward.find(params[:id])
    reward.update(reward_params)
      if reward.errors.present?
        render json: { error_msg: reward.errors.full_messages }, status: :unprocessable_entity
      else
        render json: reward
    end
  end

  def destroy
    reward = Reward.find(params[:id])
    if reward.destroy
      render json: reward
    end
  end

  def complete
    reward = Reward.find(params[:id])
    user = User.find(reward.user_id)
    if user.point <= reward.point
      render json: {error_msg: ["コインが足りません"]}, status: :unprocessable_entity
    else
      user = User.find(reward.user_id)
      losepoint = user.point.to_i
      losepoint -= reward.point

      reward.update(status: true)
      user.update(point: losepoint)
      user.point = losepoint
      render json: {reward: reward, user: user}
    end
  end

  def sort
    params[:reward].each_with_index do |t,i|
      @reward = Reward.find(t[:id])
      @reward.update( sort: i )
    end
    render json: {result: "ok"}
  end 

  private
    def reward_params
      params.require(:reward).permit(:title, :user_id, :point, :status, :sort)
    end
end
