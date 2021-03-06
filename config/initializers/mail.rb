ActionMailer::Base.smtp_settings = {
  port:              587,
  address:           'smtp.mailgun.org',
  user_name:         'postmaster@sandbox779bb57c0322408296ede3717a377346.mailgun.org',
  password:          'fe39242e3e1f94937ed13c9b2559dd54',
  domain:            'appurlhere.com',
  authentication:    :plain,
  content_type:      'text/html'
}
ActionMailer::Base.delivery_method = :smtp

# Makes debugging *way* easier.
ActionMailer::Base.raise_delivery_errors = true

# This interceptor just makes sure that local mail
# only emails you.
# http://edgeguides.rubyonrails.org/action_mailer_basics.html#intercepting-emails
class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.to =  'rissgadi@gmail.com'
    message.cc = nil
    message.bcc = nil
  end
end

# Locally, outgoing mail will be 'intercepted' by the
# above DevelopmentMailInterceptor before going out
if Rails.env.production?
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)
end
