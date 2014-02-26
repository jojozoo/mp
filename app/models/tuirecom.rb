class Tuirecom < Tui
  belongs_to :obj, polymorphic: true, counter_cache: :recoms_count
end