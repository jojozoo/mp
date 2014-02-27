class Tuilaud < Tui
    belongs_to :obj, polymorphic: true, counter_cache: :lauds_count
end