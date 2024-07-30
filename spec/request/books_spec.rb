require 'rails_helper'

describe 'Books API', type: :request do
    describe 'Get /books' do
        it 'returns all books' do
            FactoryBot.create(:book, title: "Mr Lonely Boy", year: 2023, author: "Jamal hamadi")
            FactoryBot.create(:book, title: "Mr Lonely Girl", year: 2023, author: "Jamal hamadi")

            get '/api/v1/books'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end  
    end

    describe 'POST /books' do
        it 'create new book' do
            post '/api/v1/books', params: {book: {title: "Mr Lonely Boy", year: 2023, author: "Jamal hamadi"}}

            expect(response).to have_http_status(:created)
        end
    end

    describe 'DELETE /books' do
        it 'deletes book by id' do
            # Create a book and store the created book object
            book = FactoryBot.create(:book, title: "Mr Lonely Boy", year: 2023, author: "Jamal hamadi")
            
            # Send a DELETE request to the API endpoint using the book's ID
            delete "/api/v1/books/#{book.id}"
            
            # Check that the response status is 204 No Content
            expect(response).to have_http_status(:no_content) # use :no_content for delete
            
            # Optionally, ensure that the book has been deleted from the database
            expect(Book.find_by(id: book.id)).to be_nil
        end
    end

    describe 'PUT /books/:id' do
        it 'returns status ok' do
            # Create a book and store the created book object
            book = FactoryBot.create(:book, title: "Mr Lonely Boy", year: 2023, author: "Jamal hamadi")
            print book
            # Send a DELETE request to the API endpoint using the book's ID
            put "/api/v1/books/#{book.id}", params: {book:{title: "lalalond",year: 2022,author:"dubbo"}}
            
            expect(response).to have_http_status(:ok)
            updated_book = Book.find(book_id)
            expect(updated_book.title).to eq("lalalond")
            expect(updated_book.year).to eq(2022)
            expect(updated_book.author).to eq("New dubbo")
        end
    end


end