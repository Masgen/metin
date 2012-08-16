class IdentitiesController < ApplicationController
  before_filter :authenticate, except: :show
  def show
    @identity = Identity.first
    @employees = Employee.all
  end
  
  def edit
    @identity = Identity.first
  end
  
  def update
    @identity = Identity.first
    if @identity.update_attributes(params[:identity])
      redirect_to identity_path, notice: "Successfully updated."
    else
      render "edit"
    end
  end
end
