require 'rails_helper'
require 'movie.rb'

describe "Movie" do
    it "should be defined" do
        expect { Movie }.not_to raise_error
    end
    
    describe ".all_ratings" do
        it 'should return all ratings' do
            expect(Movie.all_ratings).to match_array(%w(G PG PG-13 NC-17 R))
        end
    end
    
    describe ".similar_director_movies" do
        before(:each) do
            Movie.create(:title => 'hi', :director => 'hi_dir')
            Movie.create(:title => 'hi2', :director => 'hi_dir')
            Movie.create(:title => 'hi3', :director => 'hi_dir')
            Movie.create(:title => 'bye', :director => 'bye_dir')
            Movie.create(:title => 'bye2', :director => 'bye_dir')
            Movie.create(:title => 'bye3', :director => 'bye_dir')
        end
  
        it 'should find movies by the same director' do
            expect(Movie.similar_director_movies('hi_dir')).to include(Movie.where(:director => 'hi_dir').first)
        end
        
        it 'should not find movies by different directors' do
            expect(Movie.similar_director_movies('hi_dir')).to_not include(Movie.where(:director => 'bye_dir').first)
        end
    end
end
