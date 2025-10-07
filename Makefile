SOURCES =\
			lib/program_type.ml\
			lib/program_validation.ml\
			lib/turing_load_machine.ml\
			lib/run_machine.ml\
			bin/validate_program.ml\
			bin/info_print.ml\
			bin/parsing_turing.ml\
			bin/main.ml
RESULT  = ft_turing
PACKS = jsont jsont.bytesrw fileutils

-include OCamlMakefile
