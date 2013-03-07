class StatementTables < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :follow_up_question
      t.references :creator
      t.references :node
      t.timestamps
    end
    create_table :proposals do |t|
      t.references :question, null: false
      t.references :creator
      t.references :node
      t.timestamps
    end
    create_table :improvements do |t|
      t.references :proposal, null: false
      t.references :creator
      t.references :node
      t.timestamps
    end
    create_table :pro_arguments do |t|
      t.references :proposal, null: false
      t.references :creator
      t.references :node
      t.timestamps
    end
    create_table :contra_arguments do |t|
      t.references :proposal, null: false
      t.references :creator
      t.references :node
      t.timestamps
    end
    create_table :follow_up_questions do |t|
      t.references :statement, polymorphic: true, null: false
      t.timestamps
    end
    create_table :background_infos do |t|
      t.references :statement, polymorphic: true, null: false
      t.references :creator
      t.references :node
      t.timestamps
    end

    create_table :nodes do |t|

    end

    # join tables for belongs to many relations
    create_table :proposal_alternatives do |t|
      t.references :proposal
      t.references :alternative
      t.references :creator
    end
    create_table :improvement_alternatives do |t|
      t.references :improvement
      t.references :alternative
      t.references :creator
    end
    create_table :pro_argument_alternatives do |t|
      t.references :pro_argument
      t.references :alternative
    end
    create_table :contra_argument_alternatives do |t|
      t.references :contra_arguments
      t.references :alternative
    end

    # echoable properties
    create_table :echos do |t|
      t.references :echoable, polymorphic: true, null: false
      t.integer :visitor_count, default: 0
      t.integer :supporter_count, default: 0
      t.timestamps
    end

    create_table :user_echos do |t|
      t.references :echo, null: false
      t.references :user, null: false
      t.boolean    :visited, default: false
      t.boolean    :supported, default: false
      t.timestamps
    end

    # users
    create_table :users do |t|
      t.timestamps
    end
  end
end
