class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(post_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
