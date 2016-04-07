require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:todo) {FactoryGirl.create(:todo)}
  it 'has a valid factory' do
    expect(todo).to be_valid
  end
  it 'is invalid without name' do
    todo.name = nil
    expect(todo).not_to be_valid
  end
  it 'is valid without description' do
    todo.name = "MyString"
    todo.description = nil
    expect(todo).to be_valid
  end
end
