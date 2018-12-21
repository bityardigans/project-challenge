require "rails_helper"

RSpec.feature "Home page", :type => :feature do
  scenario "New user lands on site" do
    2.times { create(:dog) }

    visit "/"

    expect(page).to have_selector('.dog-photo', count: 2)
    expect(page).to have_selector('.dog-name', count: 2)

    expect(page).to have_text("Sign in")
    expect(page).to have_text("Sign up")
  end

  scenario "User orders by trending" do
    create(:dog)
    d = create(:dog)

    2.times { create(:like, dog_id: d.id) }    
    
    visit "/?order_by=trending"

    expect(first('.total-likes').text.to_i).to eq(2)
  end

  scenario "User orders by total likes" do
    create(:dog)
    d = create(:dog)

    10.times { create(:like, dog_id: d.id, created_at: 10.days.ago) }
    
    visit "/?order_by=likes"

    expect(first('.total-likes').text.to_i).to eq(10)
  end  

  scenario "User orders by total name" do
    create(:dog, name: "Omega")
    d = create(:dog, name: "Alpha")
    
    visit "/?order_by="

    expect(first('.dog-name').text).to eq(d.name)
  end    
end
