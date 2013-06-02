class RegistrationsController < Devise::RegistrationsController
  
  def new
    @email_preset = params[:email_preset]
    super
  end
  
  def create
    super
  end
  
  def edit
    super
  end
  
  def update
    super
  end
  
  def destroy
    super
  end
  
  def cancel
    super
  end
  
end