;; Write your query here like `(node) @capture`,
;; put the cursor under the capture to highlight the matches.

(lexical_declaration
	(variable_declarator
   	name: (identifier) @func.name
    value: (arrow_function
      parameters: (formal_parameters
        (required_parameter
            (identifier) @func.param_names
              (type_annotation
                [
                  (predefined_type)
                  (union_type
                    (predefined_type)
                  )
                ] @func.param_types
              )
        )
      ) @func.end_point
    )
  )
) @func.definition
