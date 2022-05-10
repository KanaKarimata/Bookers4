class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    # @books = Book.all
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort {|a,b| 
    b.favorited_users.length <=> 
    a.favorited_users.length
    }
    @book_new = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = BookComment.all
  end

  def edit
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
