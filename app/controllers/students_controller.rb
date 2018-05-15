class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def create
    new_student = Student.create!(student_params)
    redirect_to student_path(new_student)
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end
end
