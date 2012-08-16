class EmployeesController < ApplicationController
  before_filter :authenticate
  def new
    @employee = Employee.new
  end
  
  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      redirect_to company_path, :notice => "New employee is successfully added."
    else
      render new_employee_path
    end
  end
  
  def edit
    @employee = Employee.find_by_id(params[:id])
  end
  
  def update
    @employee = Employee.find_by_id(params[:id])
    if @employee.update_attributes(params[:employee])
      redirect_to company_path, notice: "Employee profile is updated."
    else
      render edit_employee_path(params[:id])
    end
  end
  
  def destroy 
    Employee.find_by_id(params[:id]).destroy
    redirect_to company_path, :notice => "Employee is removed."
  end
  
  def sort
    @employees = Employee.all
    unless params[:employee].blank?
      params[:employee].each_with_index do |id, index|
        Employee.update_all({position: index+1}, {id: id})
      end
      render nothing: true
    end
  end
end
