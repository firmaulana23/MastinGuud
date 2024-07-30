module Api
  module V1
    class BooksController < ApplicationController
      def index
        render json: Book.all
      end

      def show
        book = Book.find_by(id: params[:id])
        
        if book
          render json: book, status: :ok
        else
          render json: { message: 'Book not found' }, status: :not_found
        end
      end

      def create
        book = Book.new(book_params)

        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        book = Book.find_by(id: params[:id])
        
        if book
          book.destroy
          render json: { message: "Book with ID #{params[:id]} is deleted" }, status: :no_content
        else
          render json: { message: 'Book not found' }, status: :not_found
        end
      end

      def update
        book = Book.find_by(id: params[:id])
        print book
        if book
          if book.update(book_params)
            render json: book, status: :ok
          else
            render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { message: 'Book not found' }, status: :not_found
        end
      end

      private

      def book_params
        params.require(:book).permit(:title, :author, :year)
      end
    end
  end
end
