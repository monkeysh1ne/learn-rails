class ContactsController < ApplicationController

  #instantiate empty contact model, assign to instance var and render
  #new.html.erb.
  def new
    @contact = Contact.new
  end


  #instantiate new contacts model using form data (post validation)
  def create
    @contact = Contact.new(secure_params)
    if @contact.valid?
      @contact.update_spreadsheet # save details to google_spreadsheet
      UserMailer.contact_email(@contact).deliver
      flash[:notice] = "Message sent from #{@contact.name}."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:contact).permit(:name, :email, :content)
  end

end