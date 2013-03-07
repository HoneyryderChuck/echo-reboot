class ContraArgument < Argument
  has_and_belongs_to_many :alternatives, class_name: "ProArgument", association_foreign_key: :alternative_id, join_table: :contra_argument_alternatives
end