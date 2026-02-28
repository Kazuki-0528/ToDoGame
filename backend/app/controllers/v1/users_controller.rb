class V1::UsersController < ApplicationController
  def index
    return head :bad_request unless params[:uid]

    user = User.find_by(uid: params[:uid])
    return render json: { error: "user not found" }, status: :not_found unless user

    todos = user.todos.order(sort: "ASC")
    render json: { user: user, todos: todos }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :uid, :name)
  end
end
