class ProArgument < Argument
  has_and_belongs_to_many :alternatives, class_name: "ContraArgument", association_foreign_key: :alternative_id, join_table: :pro_argument_alternatives
end