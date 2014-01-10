# module Scopes
#   def self.included(base)
#     base.class_eval do
#       def self.not_older_than(interval)
#         scoped(:conditions => ["#{table_name}.created_at > ?", interval.ago])
#       end
#     end
#   end
# end
# ActiveRecord::Base.send(:include, Scopes)
# class User < ActiveRecord::Base
# end
# ##### or 
# class ActiveRecord::Base
#   # default_scope
#   scope :this_month,  lambda { where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month) }
# end
# class User < ActiveRecord::Base
#   default_scope { where(del: false) }
#   scope :del,  lambda { where(del: true) }
#   # unscoped 也可重新定义
# end
# User.all #=> select * from users where del = 0;
# User.del #=> select * from users where del = 1;
# User.unscoped.all #=> select * from users;