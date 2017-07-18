class ContactsController < ApplicationController
    #GET request to /contact-us 
    #Show new contact form
    def new
        @contact = Contact.new
    end
    #POST request /contact
    def create
        #mass asignment of formfiled into Contact object
       @contact = Contact.new(contact_params)
       #save the Contact object to the database
       if @contact.
           #Store formfields via params, into variables
           name = params[:contact][:name]
           email = params[:contact][:email]
           body = params[:contact][:comments]
           #Plug vars into contact_mailer email method, send mail
           ContactMailer.contact_email(name,emal,body).deliver
           #Store success message in flash hash and redirect to the new action
           flash[:success] = "message sent"
           redirect_to new_contact_path
           
        else
            #if contact object doesnt save store errores in flash hash
            #and redirect to new action
            flash[:danger] = @contact.errors.full_messages.join(", ").html_safe
            redirect_to new_contact_path
        end
    end
    private
    #To collect data from form we need to use 
    #String params and whitelist the form fields
        def contact_params
            params.require(:contact).permit(:name,:email,:comments)
        end
end