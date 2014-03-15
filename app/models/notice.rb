# == Schema Information
#
# Table name: notices
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  sends_id   :integer
#  title      :string(255)
#  content    :text
#  read       :boolean
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notice < ActiveRecord::Base
  attr_accessible :content, :read, :sends_id, :title, :user_id
end
