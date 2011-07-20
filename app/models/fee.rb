class Fee < ActiveRecord::Base
  acts_as_indexed :fields => [:from_account, :message]

  belongs_to :user
  
  def self.search(search, page, user)
    paginate :per_page => 20, :page => page,
#             :conditions => ['(from_account like ? OR message like ?)', "%#{search}%", "%#{search}%"],
             :conditions => ['user_id = ? AND (from_account like ? OR message like ?)', user.id, "%#{search}%", "%#{search}%"],
             :order => 'year DESC, month DESC'
  end

  def self.mine(page, user)
    paginate :per_page => 20, :page => page,
             :conditions => ['user_id = ?', user.id],
             :order => 'year DESC, month DESC'
  end


end