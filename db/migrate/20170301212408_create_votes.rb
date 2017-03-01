class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.boolean :is_up

      t.timestamps
    end
    # this type of index is a composite index, where we're indexing in more than one field
    # its a good idea to put such index of our queries incluidng both user_id and question_id in them
    # add_index :votes, [:user_id, :question_id]
  end
end
