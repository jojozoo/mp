class Tuilike < Tui
  belongs_to :obj, polymorphic: true, counter_cache: :likes_count
end