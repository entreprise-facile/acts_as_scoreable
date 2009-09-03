ActiveRecord::Schema.define(:version => 0) do
  create_table :entries, :force => true do |t|
    t.string :name
    t.integer :score, :default => 0
  end
  create_table :events, :force => true do |t|
    t.string :name
    t.integer :points, :default => 0
  end
end