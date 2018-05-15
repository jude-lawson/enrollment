require 'rails_helper'

RSpec.describe 'Navigation' do
  before :each do
    @student1 = Student.create!(first_name: 'Jude', last_name: 'Dutton')
    @student2 = Student.create!(first_name: 'Sally', last_name: 'Sparrow')
    @student3 = Student.create!(first_name: 'Jack', last_name: 'Harkness')
  end

  context '/students' do
    it 'should have navigation links' do
      visit students_path

      expect(page).to have_content('All Students')
      expect(page).to have_content('Create New Student')
    end

    it 'the user should be able to click \'All Students\' to and see students page' do
      visit students_path

      click_link('All Students')
      expect(current_path).to eq(students_path)
    end

    it 'the user should be able to click \'Create New Student\' to see the new student form page' do
      visit students_path

      click_link('Create New Student')
      expect(current_path).to eq(new_student_path)
    end
  end

  context '/students/new' do
    it 'should have navigation links' do
      visit new_student_path

      expect(page).to have_content('All Students')
      expect(page).to have_content('Create New Student')
    end

    it 'the user should be able to click \'All Students\' to and see students page' do
      visit new_student_path

      click_link('All Students')
      expect(current_path).to eq(students_path)
    end

    it 'the user should be able to click \'Create New Student\' to see the new student form page' do
      visit new_student_path

      click_link('Create New Student')
      expect(current_path).to eq(new_student_path)
    end
  end

  context '/student/:id/edit' do
    it 'should have navigation links' do
      visit edit_student_path(@student2)

      expect(page).to have_content('All Students')
      expect(page).to have_content('Create New Student')
    end

    it 'the user should be able to click \'All Students\' to and see students page' do
      visit edit_student_path(@student2)

      click_link('All Students')
      expect(current_path).to eq(students_path)
    end

    it 'the user should be able to click \'Create New Student\' to see the new student form page' do
      visit edit_student_path(@student2)

      click_link('Create New Student')
      expect(current_path).to eq(new_student_path)
    end
  end

  context 'student/:id' do
    it 'should have navigation links' do
      visit student_path(@student3)

      expect(page).to have_content('All Students')
      expect(page).to have_content('Create New Student')
    end

    it 'the user should be able to click \'All Students\' to and see students page' do
      visit student_path(@student3)

      click_link('All Students')
      expect(current_path).to eq(students_path)
    end

    it 'the user should be able to click \'Create New Student\' to see the new student form page' do
      visit student_path(@student3)

      click_link('Create New Student')
      expect(current_path).to eq(new_student_path)
    end
  end
end
