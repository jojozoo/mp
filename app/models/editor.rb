# == Schema Information
#
# Table name: editors
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  editor_id  :integer
#  sum        :integer
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Editor < ActiveRecord::Base
  attr_accessible :event_id, 
  :editor_id, 
  :sum, 
  :del
  belongs_to :editor, class_name: 'User', foreign_key: :editor_id
  belongs_to :event
end
