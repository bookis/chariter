class CreateCommitments < ActiveRecord::Migration
  def self.up
    create_table :commitments do |t|
      t.belongs_to :user
      t.string :delay_period, :organization_url, :name
      t.integer :amount, :amount_in_cents, :credit, :credit_in_cents
      t.datetime :end_date
      t.timestamps
    end
    create_table :tasks do |t|
      t.datetime :due_date
      t.boolean :succeeded
      t.belongs_to :commitment

      t.timestamps
    end
    add_index :commitments, :user_id  
    add_index :tasks, :commitment_id
  end

  def self.down
    remove_index :tasks, :commitment_id
    remove_index :commitments, :user_id
    drop_table :commitments
    drop_table :tasks
  end
end