require 'refinerycms-base'

module Refinery
  module Fees
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
      
      config.to_prepare do
        User.module_eval do
          has_many :fees
          
          def identifications
            fees = Fee.where(:vs => self.progressbar_uid)
            acc = []
#            fees.each do |f| acc << f.from_account
            fees.each do |f|
              acc << f.from_account
            end
#            bank_accounts = Fee.where(:vs => self.progressbar_uid).collect {|f| "#{f[:from_account]}"}.join(' - ')
            "#{self.progressbar_uid} - #{self.username} - #{self.progressbar_screenname.to_s} - #{acc.uniq.join(' - ').to_s}"
          end
        end
      end
      
      
      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = 'fees'
          plugin.activity = {
            :class => Fee,
            :title => 'from_account'
          }
        end
      end
    end
  end
end
