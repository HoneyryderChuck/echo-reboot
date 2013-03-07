class StatementTables < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :follow_up_question
    end
    create_table :proposals do |t|
      t.references :question, null: false
    end
    create_table :improvements do |t|
      t.references :proposal, null: false
    end
    create_table :pro_arguments do |t|
      t.references :proposal, null: false
    end
    create_table :contra_arguments do |t|
      t.references :proposal, null: false
    end
    create_table :follow_up_questions do |t|
      t.references :statement, polymorphic: true, null: false
    end
    create_table :background_infos do |t|
      t.references :statement, polymorphic: true, null: false
    end

    create_table :proposal_alternatives do |t|
      t.references :proposal
      t.references :alternative
    end
    create_table :improvement_alternatives do |t|
      t.references :improvement
      t.references :alternative
    end
    create_table :pro_argument_alternatives do |t|
      t.references :pro_argument
      t.references :alternative
    end
    create_table :contra_argument_alternatives do |t|
      t.references :contra_arguments
      t.references :alternative
    end
  end
end
