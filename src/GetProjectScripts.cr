require "./CompilationHelper.cr"

script_files = CompilationHelper.get_all_specific_scripts_from_project_file(ARGV[0], ARGV[1])

puts script_files