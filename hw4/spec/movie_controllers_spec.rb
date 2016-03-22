require 'rails_helper'
require 'movies_controller.rb'

RSpec.feature "Similar movies", :type => :feature do
  before(:each) do
    movies = [{:title => 'Aladdin', :rating => 'G', :release_date => '25-Nov-1992', :director => 'Bob'},
    	  {:title => 'The Terminator', :rating => 'R', :release_date => '26-Oct-1984', :director => 'Bob'},
    	  {:title => 'When Harry Met Sally', :rating => 'R', :release_date => '21-Jul-1989', :director => 'Bob'},
      	  {:title => 'The Help', :rating => 'PG-13', :release_date => '10-Aug-2011', :director => 'Josh'},
      	  {:title => 'Chocolat', :rating => 'PG-13', :release_date => '5-Jan-2001', :director => 'Josh'},
      	  {:title => 'Amelie', :rating => 'R', :release_date => '25-Apr-2001', :director => 'Josh'},
      	  {:title => '2001: A Space Odyssey', :rating => 'G', :release_date => '6-Apr-1968', :director => 'Smith'},
      	  {:title => 'The Incredibles', :rating => 'PG', :release_date => '5-Nov-2004', :director => 'Smith'},
      	  {:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981', :director => 'Smith'},
      	  {:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000'},
    ]
    
    movies.each do |movie|
      Movie.create!(movie)
    end

  end
  
  scenario "When the specified movie has a director" do
    visit "/movies/1"
    click_link "Find Movies With Same Director"
    current_path.should == "/movies/1/similar_movies"
  end
  
  scenario "When the specified movie has no director" do
    visit "/movies/10"
    click_link "Find Movies With Same Director"
    current_path.should == "/movies"
  end
  
  scenario "should be able to create a movie" do
    visit "/movies/new"
    fill_in "Title", :with => "good_movie"
    click_button "Save Changes"
    expect(Movie.find_by_title("good_movie").title).to eq "good_movie"
  end
  
  scenario "should be able to delete a movie" do
    visit "/movies/1"
    click_button "Delete"
    expect(Movie.find_by_title("Aladdin")).to eq nil
  end
end

# describe "MoviesController" do
#     describe "#create" do
#         it "should be able to create" do
#             visit "/movies/new"
#             fill_in "Title", "good_movie"
#             click_button "Save Changes"
#             expect(Movie.find_by_title("new").title).to eq "good_movie"
#         end
#     end
# end