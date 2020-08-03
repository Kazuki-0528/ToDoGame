class V1::TodosController < ApplicationController
  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: todo, status: :created #todoに保存したデータが入っている
    else                                  #title, user_id, created_at, updated_at
      render json: todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    if todo.destroy
      render json: todo                   #todoにデータが入っている
    end                                   #title, user_id, created_at, updated_at
  end 

  def complete  #todo達成用
    todo = Todo.find(params[:id])      #paramsにはactionのcompleteが入ってる
  end 

  private
    def todo_params
      #pointを送れた
      params.require(:todo).permit(:title, :user_id, :point)   #{"todo"=>{"title"=>"英語", "user_id"=>6, "point"=>2}, "controller"=>"v1/todos", "action"=>"create"} permitted: false>
    end                                                #paramsにはこんだけの情報が入っている
end
