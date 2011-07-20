module NavigationHelpers
  module Refinery
    module Fees
      def path_to(page_name)
        case page_name
        when /the list of fees/
          admin_fees_path

         when /the new fee form/
          new_admin_fee_path
        else
          nil
        end
      end
    end
  end
end
