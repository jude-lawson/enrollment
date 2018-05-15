require 'rails_helper'

RSpec.describe 'Student Pages' do
  before :each do
    @student1 = Student.create!(first_name: 'Jude', last_name: 'Dutton')
    @student2 = Student.create!(first_name: 'The', last_name: 'Doctor')
    @student3 = Student.create!(first_name: 'Jack', last_name: 'Harkness')

    @address1 = Address.create!(description: 'Permanent address', 
                                street_address: '555 Not A Real Street',
                                city: 'Notacity',
                                state: 'Notastate',
                                zip_code: 00000, student_id: @student2.id)
@address2 = Address.create!(description: 'Summer address',
                            street_address: '000 The Doctor Way',
                            city: 'Gallifrey',
                            state: 'Kastaberous',
                            zip_code: 00001, student_id: @student2.id)
  end

  context '/students' do
    describe 'A user visits the students page' do
      it 'they should see a list of all students' do
        visit students_path
        
        expect(page).to have_content("#{@student1.first_name} #{@student1.last_name}")
        expect(page).to have_content("#{@student2.first_name} #{@student2.last_name}")
        expect(page).to have_content("#{@student3.first_name} #{@student3.last_name}")
      end

      it 'they should be able to click on any students name and be taken to the correct show page' do
        visit students_path

        click_link("#{@student1.first_name} #{@student1.last_name}")

        expect(current_path).to eq(student_path(@student1))
        expect(page).to have_content(@student1.first_name)
        expect(page).to have_content(@student1.last_name)

        visit students_path

        click_link("#{@student2.first_name} #{@student2.last_name}")

        expect(current_path).to eq(student_path(@student2))
        expect(page).to have_content(@student2.first_name)
        expect(page).to have_content(@student2.last_name)

        visit students_path

        click_link("#{@student3.first_name} #{@student3.last_name}")

        expect(current_path).to eq(student_path(@student3))
        expect(page).to have_content(@student3.first_name)
        expect(page).to have_content(@student3.last_name)
      end
    end
  end

  context '/students/:id' do
    describe 'A user visits the a specific students page' do
      it 'they should see the specific student\'s name' do
        visit student_path(@student2)

        expect(page).to have_content("#{@student2.first_name} #{@student2.last_name}")

        expect(page).to_not have_content("#{@student1.first_name} #{@student1.last_name}")
        expect(page).to_not have_content("#{@student3.first_name} #{@student3.last_name}")
      end

      it 'they should see all of the student\'s addresses' do
        visit student_path(@student2)

        expect(page).to have_content(@address1.description)
        expect(page).to have_content(@address1.street_address)
        expect(page).to have_content(@address1.city)
        expect(page).to have_content(@address1.state)
        expect(page).to have_content(@address1.zip_code)
        expect(page).to have_content(@address2.description)
        expect(page).to have_content(@address2.street_address)
        expect(page).to have_content(@address2.city)
        expect(page).to have_content(@address2.state)
        expect(page).to have_content(@address2.zip_code)
      end
    end
  end

  context '/students/new' do
    describe 'A user visits the new student page' do
      it 'they should be able to create a new student' do
        visit new_student_path

        fill_in 'student[first_name]', with: 'Rose'
        fill_in 'student[last_name]', with: 'Tyler'
        click_button 'Create Student'

        new_student = Student.last

        expect(current_path).to eq(student_path(new_student))
      end
    end
  end

  context 'students/:id/edit' do
    describe 'A user visits the edit student page' do
      it 'they should be able to edit student details' do
        visit edit_student_path(@student3)

        new_first_name = 'Face Of'
        new_last_name = 'Bo'

        fill_in 'student[first_name]', with: new_first_name
        fill_in 'student[last_name]', with: new_last_name
        click_button 'Update Student'

        expect(current_path).to eq(student_path(@student2))
        expect(page).to have_content(new_first_name)
        expect(page).to have_content(new_last_name)
      end
    end
  end

  context '/students' do
    describe 'A user visits the students page' do
      it 'they should be able to delete a student' do
        visit students_path

        within("#student-" + @student1.id.to_s) do
          click_link('Delete')
        end

        expect(current_path).to eq(students_path)
        expect(page).to have_content(@student3.first_name)
        expect(page).to have_content(@student3.last_name)

        expect(page).to have_content(@student2.first_name)
        expect(page).to have_content(@student2.last_name)

        expect(page).to_not have_content(@student1.first_name)
        expect(page).to_not have_content(@student1.last_name)
      end
    end
  end
end
