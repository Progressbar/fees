module Admin
  class FeesController < Admin::BaseController
    crudify :fee, :xhr_paging => true

    layout proc{ |c| c.request.xhr? ? false : 'admin' }

    def index
      @fees = params[:search] ? Fee.search(params[:search], params[:page], current_user) : Fee.mine(params[:page], current_user)

      render(:partial => 'fees') if request.xhr?
    end

    def show
      @fee = Fee.find_by_id(params[:id])
      @users = User.all
    end

    def pair
      unless current_user.has_role?(:superuser)
        flash[:error] = 'Bad, bad boy!'
        redirect_to :action => 'index'
      else
        if params[:fee]
          pfs = params[:fee]
          pfs.each do |id, vs|
            if params[:fee][id][:vs]
              fee = Fee.find(id)
              user = User.find_by_progressbar_uid(params[:fee][id][:vs])
              unless user.nil?
                fee.update_attribute(:vs, user.progressbar_uid)
                fee.update_attribute(:user_id, user.id)
              end
            end
          end

          flash[:notice] = 'Fees was updated. Thank You!'
        end
        
        redirect_to :action => 'unpaired'
      end      
    end

    def paired
      if current_user.has_role?(:superuser)
        @fees = Fee.paired
        @fees = @fees.paginate({:page => params[:page]})

        render(request.xhr? ? {:partial => 'fees' } : {:action => 'index'})
      else
        redirect_to :action => 'index'
      end
    end

    def unpaired
      if current_user.has_role?(:superuser)
        @fees = Fee.unpaired
        @fees = @fees.paginate({:page => params[:page]})

        render(request.xhr? ? {:partial => 'fees' } : {:action => 'index'})
      else
        redirect_to :action => 'index'
      end
    end
  end
end