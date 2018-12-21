require 'rails_helper'
require 'pp'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Dog resource', type: :feature do    
  let(:user) { create(:user) }
  let!(:current_user) { login_as(user, scope: :user) } 

  it 'can create a profile' do    
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'    
    expect(Dog.count).to eq(1)
  end

  it 'can edit a dog profile' do
    dog = create(:dog, user_id: user.id)        
    
    visit edit_dog_path(dog)
    fill_in 'Name', with: 'Speck'
    click_button 'Update Dog'
    expect(dog.reload.name).to eq('Speck')
  end

  it 'can delete a dog profile' do
    dog = create(:dog, user_id: user.id)

    visit dog_path(dog)
    click_link "Delete #{dog.name}'s Profile"
    expect(Dog.count).to eq(0)
  end
  
  it 'cannot edit a dog profile that is not mine' do
    dog = create(:dog)        
    
    visit edit_dog_path(dog)    

    assert has_no_field?('Name')
  end

  it 'cannot delete a dog profile that is not mine' do
    dog = create(:dog)        
    
    visit edit_dog_path(dog)    

    assert has_no_button?("Delete #{dog.name}'s Profile")
  end  

  it 'cannot like my own dog' do
    dog = create(:dog, user_id: user.id)        
    
    visit "/"

    assert has_css?(".my-dog-likes")
  end    
end
