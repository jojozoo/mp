class ActiveRecord::Base
  # 可以这样定义 
  # 也可以下面方法定义 
  # singleton_class 应该代表继承者的class
  def self.default_scope
    where(del: false).order('id desc')
  end

  singleton_class.instance_eval do
    # 这样
    # define_method :default_scope do
    #   where(del: false)
    # end
    
    define_method :del do
      where(del: true)
    end
  end
  # unscoped -> { where(del: true) }
end
# class User < ActiveRecord::Base
#   default_scope { where(del: false) }
#   scope :del,   { where(del: true) }
#   # unscoped 也可重新定义
# end
# User.all #=> select * from users where del = 0;
# User.del #=> select * from users where del = 1;
# User.unscoped.all #=> select * from users;