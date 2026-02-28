class V1::TodosController < ApplicationController
  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, status: :created
    else
      if todo.errors.present?
        render json: {error_msg: todo.errors.full_messages, todo: todo}, status: :unprocessable_entity
      else 
        render json: todo.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    todo = Todo.find(params[:id])
    todo.update(todo_params)
    if todo.errors.present?
      render json: {error_msg: todo.errors.full_messages, todo: todo}, status: :unprocessable_entity
    else 
      render json: todo
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    if todo.destroy
      render json: todo
    end
  end

  def complete
    todo = Todo.find(params[:id])
    user = User.find(todo.user_id)

    totalPoint = user.point.to_i
    totalPoint += todo.point
    user.point = totalPoint

    totalExp = user.experience_point
    totalExp += todo.point
    user.experience_point = totalExp
    user.update(point: totalPoint,experience_point: totalExp)

    if user.experience_point < 6
      user.status = '冒険者'
      user.update(status: user.status)
    elsif 6 <= user.experience_point && user.experience_point < 20
      user.status = '見習い剣士'
      user.update(status: user.status)
    elsif 20 <= user.experience_point && user.experience_point < 30
      user.status = '剣士'
      user.update(status: user.status)
    elsif 30 <= user.experience_point && user.experience_point < 50
      user.status = '上級剣士'
      user.update(status: user.status)
    elsif 50 <= user.experience_point && user.experience_point < 60
      user.status = '狂剣士'
      user.update(status: user.status)
    elsif 60 <= user.experience_point && user.experience_point < 70
      user.status = '剣豪'
      user.update(status: user.status)
    elsif 70 <= user.experience_point && user.experience_point < 80
      user.status = '剣聖'
      user.update(status: user.status)
    elsif 80 <= user.experience_point && user.experience_point < 95
      user.status = '剣神'
      user.update(status: user.status)
    else 
      user.status = '伝説の英雄'
      user.update(status: user.status)
    end
    
    if todo.destroy
      render json: {todo: todo, user: user}
    end
  end

  def sort
    params[:todo].each_with_index do |t,i|
      @todo = Todo.find(t[:id])
      @todo.update( sort: i )
    end
    render json: {result: "ok"}
  end

  private
    def todo_params
      params.require(:todo).permit(:title, :user_id, :point, :sort)
    end
end