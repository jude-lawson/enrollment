require 'rails_helper'

RSpec.describe 'Student Pages' do
  before :each do
    @student1 = Student.create!(first_name: 'Jude', last_name: 'Dutton')
    @student2 = Student.create!(first_name: 'Sally', last_name: 'Sparrow')
    @student3 = Student.create!(first_name: 'Jack', last_name: 'Harkness')
  end

  context '/students' do
    describe 'A user visits the students page' do
      it 'they should see a list of all students' do
        visit students_path
        
        expect(page).to have_content("#{@student1.first_name} #{@student1.last_name}")
        expect(page).to have_content("#{@student2.first_name} #{@student2.last_name}")
        expect(page).to have_content("#{@student3.first_name} #{@student3.last_name}")
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
    end
  end
end
