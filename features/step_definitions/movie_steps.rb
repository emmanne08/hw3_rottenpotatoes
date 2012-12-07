# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  movies_table_str = page.find_by_id(:movies).text
  flunk "#{e1} should be seen before #{e2}" unless movies_table_str.index(e1) < movies_table_str.index(e2)
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  if uncheck
    rating_list.split(/, /).each {|rating| step "I uncheck \"ratings_#{rating}\""}
  else
    rating_list.split(/, /).each {|rating| step "I check \"ratings_#{rating}\""}
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Then /I should see all of the movies/ do
  flunk 'It does not show the correct number of movies' unless page.has_selector?('table#movies tr', :count => 11)
  # assert page.has_selector?('table#movies tr', :count => 11)
  # page.should have_selector('table#movies tr', :count => 11)
  #page.should have_selector('table#movies')
  #page.has_selector?('table#movies')
  
  #all_movies = ["Aladdin", "The Terminator", "When Harry Met Sally", "The Help", "Chocolat", "Amelie", "2001: A Space Odyssey", "The Incredibles", "Raiders of the Lost Ark", "Chicken Run"]
  #all_movies.each {|movie| step %Q{I should see "#{movie}"}}
  steps %Q{
    Then I should see "Aladdin"
    And I should see "The Terminator"
    And I should see "When Harry Met Sally"
    And I should see "The Help"
    And I should see "Chocolat"
    And I should see "Amelie"
    And I should see "2001: A Space Odyssey"
    And I should see "The Incredibles"
    And I should see "Raiders of the Lost Ark"
    And I should see "Chicken Run"
  }
end
