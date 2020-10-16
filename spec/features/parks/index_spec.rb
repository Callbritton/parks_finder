require 'rails_helper'

feature "user can get park data by state" do
  scenario "user picks a valid state" do
    # As a user
    # From the homepage "/"
    visit '/'
    # I select "Tennessee" from the dropdown
    # note: the :state param is given through the form in the welcome index view
    select "Tennessee", from: :state
    # And I click on "Find Parks"
    click_on "Find Parks"
    # This will be an index of all parks per state, so the path should be "/"
    expect(current_path).to eq("/parks")
    # I see the total number of parks found
    expect(page).to have_content("Total Parks: 16")
    #Leaving this for future reference:
    #expect(page).to have_css(".member", count: 7)

    #Saving data for the selected park (specified by id in the within block below)
    # to variables to clean up testing:
    name = "Andrew Johnson National Historic Site"

    description = "Andrew Johnson's complex presidency (1865-69) illustrates the Constitution at work following the Civil War. As the President and Congress disagreed on Reconstruction methods, the Constitution served as their guide on balance of powers, vetoes, and impeachment. In the end, it evolved as a living document with pivotal amendments on freedom, citizenship, and voting rights - topics still vital today."

    directions = "GPS The GPS setting for Andrew Johnson NHS may be listed as 121 Monument Ave, which is the park HQ in the National Cemetery. To arrive at the Visitor Center, use 101 North College Street, Greeneville, TN. Plane The closest airport is the Tri-Cities Regional Airport, 43 miles NE of Greeneville. From the airport, take I-81 South to exit 36 and follow the signs to Greeneville. Car From I-81S take exit 36 to Rt. 172 south to Greeneville. From I-81N take exit 23 to Rt. 11E north to Greeneville."

    hours = {:wednesday=>"10:00AM - 3:00PM",
             :monday=>"10:00AM - 3:00PM",
             :thursday=>"10:00AM - 3:00PM",
             :sunday=>"Closed",
             :tuesday=>"10:00AM - 3:00PM",
             :friday=>"10:00AM - 3:00PM",
             :saturday=>"Closed"
            }

    # And I should see the required attributes for each park:
    within("#park-info-2ED6E071-57AA-4B08-8DDA-5CB09FBB75C8") do
      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content(directions)
      expect(page).to have_content(hours)
    end
  end
end
