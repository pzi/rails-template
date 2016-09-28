require 'rails_helper'

feature 'Admin can close their account' do

  signed_in_as(:admin) do
    before do
      click_header_option("My Profile")
    end

    scenario do
      click_link("Close my account")

      expect(page).to have_flash(:notice, "Bye! Your account was successfully closed. We hope to see you again soon.")
      expect(current_path).to eq(root_path)
      expect(User.count).to eq(0)
    end

  end
end
