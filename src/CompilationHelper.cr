require "json"

module CompilationHelper
  def self.get_all_scripts_from_project_file(directory, project_file)
    content = File.open(File.join(directory, project_file)) do |file|
      JSON.parse(file)
    end

    # TODO: Check version if available
    content_scripts = content["scripts"].as_a

    all_script_entries = [] of String

    content_scripts.each do |script_entry|
      all_script_entries.push(script_entry.as_s)
    end

    all_script_entries
  end

  def self.get_all_features_from_project_file(directory, project_file)
    content = File.open(File.join(directory, project_file)) do |file|
      JSON.parse(file)
    end

    all_features = [] of String

    if content["required_features"]?
      required_features = content["required_features"].as_a

      required_features.each do |feature|
        all_features.push(feature.as_s)
      end
    end

    all_features
  end

  def self.get_all_specific_files_from_directory(directory)
    all_specific_scripts = [] of String

    Dir.glob(File.join(directory, "**/**.rb")) do |script_file|
      all_specific_scripts.push(script_file)
    end

    all_specific_scripts
  end

  def self.get_all_specific_scripts_from_project_file(directory, project_file)
    project_scripts = self.get_all_scripts_from_project_file(directory, project_file)

    all_specific_scripts = [] of String

    project_scripts.each do |script_entry|
      script_entry_file = File.join(directory, script_entry)

      if File.directory?(script_entry_file)
        all_specific_scripts += self.get_all_specific_files_from_directory(script_entry_file)
      elsif File.exists?(script_entry_file)
        all_specific_scripts.push(script_entry_file)
      else
        raise "Could not find file or directory: #{script_entry_file}"
      end
    end

    all_specific_scripts
  end
end