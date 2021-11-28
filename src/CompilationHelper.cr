require "json"

module CompilationHelper
  def self.get_all_specific_scripts_from_project_file(directory, project_file)
    scripts = self.get_all_scripts_from_project_file(directory, project_file)

    all_specific_scripts = [] of String

    scripts.each do |script_entry|
      script_entry_file = File.join(directory, script_entry)

      if File.directory?(script_entry_file)
        Dir.glob(File.join(script_entry_file, "**/**.rb")) do |script_file|
          all_specific_scripts.push(script_file)
        end
      elsif File.exists?(script_entry_file)
        all_specific_scripts.push(script_entry_file)
      else
        raise "Could not find file or directory: #{script_entry_file}"
      end
    end

    all_specific_scripts
  end

  def self.get_all_scripts_from_project_file(directory, project_file)
    content = File.open(File.join(directory, project_file)) do |file|
      JSON.parse(file)
    end

    # TODO: Check version
    version = content["shidacea_version"].as_s
    scripts = content["scripts"].as_a

    all_script_entries = [] of String

    scripts.each do |script_entry|
      all_script_entries.push(script_entry.as_s)
    end

    all_script_entries
  end
end