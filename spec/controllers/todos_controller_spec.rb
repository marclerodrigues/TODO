require 'rails_helper'

RSpec.describe TodosController, type: :controller do

  describe 'GET #index' do
    before :each do
      @todo = FactoryGirl.create(:todo)
    end

    it 'populates the array of todos' do
      get :index
      expect(assigns(:todos)).to eq([@todo])
    end
  end

  describe 'GET #show' do
    before :each do
      @todo = FactoryGirl.create(:todo)
      get 'show', :format => :json, :id => @todo.id
    end

    it 'return success' do
      expect(response).to be_success
    end

    it 'return the correct todo' do
      expect(assigns(:todo)).to eq(@todo)
    end
  end

  describe 'POST #create' do
    context 'with valid params'  do
      it 'creates a new todo' do
        expect {
          post :create, {:todo => FactoryGirl.attributes_for(:todo)}
        }.to change(Todo, :count).by(1)
      end
      it 'assigns a newly created todo as @todo' do
        post :create, {:todo => FactoryGirl.attributes_for(:todo)}
        expect(assigns(:todo)).to be_a(Todo)
        expect(assigns(:todo)).to be_persisted
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsave todo as @todo' do
        post :create, {:todo => FactoryGirl.attributes_for(:invalid_todo)}
        expect(assigns(:todo)).to be_a_new(Todo)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the requested todo' do
        todo = FactoryGirl.create(:todo, name: "Todo app", description: "Just another app")
        put :update, {:id => todo.id, :todo => FactoryGirl.attributes_for(:todo, name:"NEW Todo App")}
        todo.reload
        expect(todo.name).to eq("NEW Todo App")
      end
    end

    context 'with invalid attributes' do
      it 'does not saves the todo' do
        todo = FactoryGirl.create(:todo, name: "Marcle")
        put :update, {:id => todo.id, :todo => FactoryGirl.attributes_for(:todo, name: nil)}
        todo.reload
        expect(todo.name).to eq("Marcle")
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @todo = FactoryGirl.create(:todo)
    end

    it 'deletes the todo' do
      expect {
        delete :destroy, id: @todo.id
      }.to change(Todo, :count).by(-1)
    end
   end
end
