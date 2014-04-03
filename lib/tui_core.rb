module TuiCore
  extend ActiveSupport::Concern
  
  included do
    has_many :tuilikes, as: :obj
    has_many :tuistores, as: :obj
    has_many :tuirecoms, as: :obj

    def tuilike?(obj)
      tuilikes.exists?(user_id: obj.id)
    end

    def tuistore?(obj)
      tuistores.exists?(user_id: obj.id)
    end

    def tuirecom?(obj)
      tuirecoms.exists?(user_id: obj.id)
    end
    
    module ClassMethods
      # 取类名
      def ttt
        "hi this tui"
      end
    end
  end
end