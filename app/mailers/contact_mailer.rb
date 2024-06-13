class ContactMailer < ApplicationMailer

    class ContactMailer < ApplicationMailer
        default from: ''
      
        def contact_email(contact_params)
          @name = contact_params[:name]
          @email = contact_params[:email]
          @phone = contact_params[:phone]
          @message = contact_params[:message]
          mail(to: '', subject: 'お問い合わせがありました')
        end
      end
      
end
