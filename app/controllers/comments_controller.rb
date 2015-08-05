class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create

    @store = Store.find(params[:store_id])
    @comment = @store.comments.build(comments_params)

    @comment.user = current_user #current user
    # @comment.owner = current_owner
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        format.js
      else
          format.html { render 'stores/index' }
          format.js
      end
    end
  end

  def destroy
    @store = Store.find(params[:store_id])
    @comment = @store.comments(params[:id]).destroy
    redirect_to root_path
  end

  def edit
  end

  private 
    #proteccion para injeccion de datos
  def comments_params #nuestro modelo comment. Lo otro son los campos deo formulario
    params.require(:comment).permit(:content)
  end 

end
