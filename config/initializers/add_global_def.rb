class ActiveRecord::Base
  # singleton_class 代表继承者的class
  def self.default_scope
    where(del: false)#.order('id desc')
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


# tui 单继承变量
['Laud', 'Like', 'Store', 'Recom'].each do |c|
  Object.const_set(c, Class.new(Tui)).instance_eval <<-BELONG
    belongs_to :obj, polymorphic: true, counter_cache: true
  BELONG
end

# 这些类需要has_many tuis,likes等等
{
  'User'  => ['tuis', 'lauds', 'likes', 'stores', 'recoms'],
  'Work'  => ['tuis', 'lauds', 'likes', 'stores', 'recoms'],
  'Image' => ['tuis', 'lauds', 'likes', 'stores', 'recoms'],
  'Group' => ['tuis', 'lauds', 'likes', 'stores', 'recoms'],
  'Topic' => ['tuis', 'lauds', 'likes', 'stores', 'recoms']
}.each do |key, val|
  key.constantize.class_eval <<-HASCON
    #{val.map{|row| "has_many :" + row + ", as: :obj"}.join("\n")}
  HASCON
end