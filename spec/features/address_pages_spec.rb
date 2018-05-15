require 'rails_helper'

RSpec.describe 'Address Pages' do
  before :each do
    @student1 = Student.create!(first_name: 'Jude', last_name: 'Dutton')
    @student2 = Student.create!(first_name: 'The', last_name: 'Doctor')
    @student3 = Student.create!(first_name: 'Jack', last_name: 'Harkness')

    @address1 = Address.create!(description: 'Permanent address', 
                                street_address: '555 Not A Real Street',
                                city: 'Notacity',
                                state: 'Notastate',
                                zip_code: '00000', student_id: @student3.id)
    @address2 = Address.create!(description: 'Summer address',
                                street_address: '000 The Doctor Way',
                                city: 'Gallifrey',
                                state: 'Kastaberous',
                                zip_code: '00001', student_id: @student2.id)
  end
  
  context '/students/:id/addresses/new' do
    describe 'A user visits the new address page for a student' do
      it 'they should be able to add a new address for the student' do
        visit new_student_address_path(@student3, @address1)

        new_desc = 'All other times on timeline'
        new_street_address = '1213 Tardis Circle'
        new_city = 'TimeAndSpace'
        new_state = 'Theuniverse'
        new_zip_code = '00002'

        fill_in 'address[description]', with: new_desc
        fill_in 'address[street_address]', with: new_street_address
        fill_in 'address[city]', with: new_city
        fill_in 'address[state]', with: new_state
        fill_in 'address[zip_code]', with: new_zip_code
        click_button 'Create Address'

        expect(current_path).to eq(student_path(@student3))
        expect(page).to have_content(new_desc)
        expect(page).to have_content(new_street_address)
        expect(page).to have_content(new_city)
        expect(page).to have_content(new_state)
        expect(page).to have_content(new_zip_code)
        expect(page).to have_content(@student3.first_name)
        expect(page).to have_content(@student3.last_name)

        expect(page).to_not have_content(@student1.first_name)
        expect(page).to_not have_content(@student1.last_name)
        expect(page).to_not have_content("#{@student2.first_name} #{@student2.last_name}")
        expect(page).to_not have_content(@address2.description)
        expect(page).to_not have_content(@address2.street_address)
        expect(page).to_not have_content(@address2.city)
        expect(page).to_not have_content(@address2.state)
        expect(page).to_not have_content(@address2.zip_code)
      end
    end
  end

end
