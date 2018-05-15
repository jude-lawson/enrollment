class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    @student_addresses = @student.addresses
  end

  def new
    @student = Student.new
  end

  def create
    new_student = Student.create!(student_params)
    redirect_to student_path(new_student)
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    updated_student = Student.update(student_params)
    redirect_to student_path(updated_student[1].id)
  end

  def destroy
    Student.find(params[:id]).destroy
    redirect_to students_path
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end
end
