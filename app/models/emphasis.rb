# == Schema Information
#
# Table name: emphases
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  link       :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Emphasis < ActiveRecord::Base
  attr_accessible :del, :link, :title
end
