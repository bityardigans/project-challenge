# Welcome

This repository contains starter code for a technical assessment. The challenges can be done at home before coming in to discuss with the Bark team or can be done as a pairing exercise at the Bark office. Either way, we don't expect you to put more than an hour or two into coding. We recommend forking the repository and getting it running before starting the challenge if you choose the pairing approach.

# Set up

Fork this repository and clone locally

You'll need [ruby 2.2.4](https://rvm.io/rvm/install) and [rails 5](http://guides.rubyonrails.org/getting_started.html#installing-rails) installed.

Run `bundle install`

Initialize the data with `rake db:reset`
# windows setup instructions
    On windows:
        rake db:drop:_unsafe
        rake db:create
        rake db:migrate
        rake db:seed
        rake db:migrate RAILS_ENV=test

Run the specs with `rspec`

Run the server with `rails s`

View the site at http://localhost:3000

# What I Did
    Add pagination to index page, to display 5 dogs per page (page query params)
    Associate dogs with owners
    Allow editing only by owner
    Allow users to like other dogs (not their own)
    Allow sorting the index page by number of likes in the last hour
    Display the ad.jpg image (saved at app/assets/images/ad.jpg) after every 2 dogs in the index page, to simulate advertisements in a feed.
    On the dog detail page that has more than one profile image, (ex http://localhost:3000/dogs/1), display profile images in a functioning carousel
        Feel free to use vanilla JS or a carousel library.
    Use flexbox, CSS grids, or a grid framework to display the homepage's dog profile thumbnails in a responsive grid layout    
    Use utility classes within a layout framework (Bootstrap, Foundation, Material Design, or another) to add a structured layout to the page without custom CSS.
    Updated tests to reflect changes
    Added additional tests    

    Screenshots of this running in chrome are in the /screenshots folder

    Credentials for the user I created are:
    josh@bityard.co
    test123

    I used VSCode on Windows 10