class Tuistore < Tui
  belongs_to :obj, polymorphic: true, counter_cache: :stores_count
end