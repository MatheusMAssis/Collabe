class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_comment, only: [ :edit, :update, :destroy ]

  def create
    @comment = @event.comments.build(comment_params)
    @comment.user = current_user
    authorize @comment

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to @event, notice: "Comment was successfully created." }
      else
        format.html { redirect_to @event, alert: "Unable to create comment." }
      end
    end
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment

    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream
        format.html { redirect_to @event, notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @comment

    @comment.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @event, notice: "Comment was successfully deleted." }
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
