require 'fileutils'

def get_value(env_var_name, default)
    ENV[env_var_name] ? ENV[env_var_name] : default
end

def determine_compiler
    if ENV["ANYOLITE_COMPILER"]
        return ENV["ANYOLITE_COMPILER"].lowercase.to_sym
    elsif ENV["VisualStudioVersion"] || ENV["VSINSTALLDIR"]
        return :msvc
    else
        return :gcc
    end
end

SHIPECTRAL_BUILD_PATH = get_value("SHIPECTRAL_BUILD_PATH", "build")
CRYSTAL_PATH = get_value("CRYSTAL_PATH", "crystal")

SHIPECTRAL_COMPILER = determine_compiler

task :default => [:install_shipectral] do
    
end

task :clean do
    FileUtils.rm_r "#{SHIPECTRAL_BUILD_PATH}" if Dir.exist?("#{SHIPECTRAL_BUILD_PATH}")
    FileUtils.rm_r "lib" if Dir.exist?("lib")
end

task :generate_build_dir do
    FileUtils.mkdir_p(SHIPECTRAL_BUILD_PATH)
end

task :build_crsfml => [:generate_build_dir] do
    if SHIPECTRAL_COMPILER == :msvc
        FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/crsfml")
        FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/crsfml/src")
        FileUtils.cp_r "third_party/crsfml/src/.", "#{SHIPECTRAL_BUILD_PATH}/crsfml/src", :verbose => true
        #FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/crsfml/spec")
        #FileUtils.cp_r "third_party/crsfml/spec/.", "#{SHIPECTRAL_BUILD_PATH}/crsfml/spec", :verbose => true
        FileUtils.cp "third_party/crsfml/make.cmd", "#{SHIPECTRAL_BUILD_PATH}/crsfml/make.cmd", :verbose => true
        system "utility/compile_crSFML.bat #{SHIPECTRAL_BUILD_PATH}"
    end
end

task :build_sfml => [:generate_build_dir] do
    FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/sfml")

    if SHIPECTRAL_COMPILER == :msvc
        system "utility/compile_SFML.bat #{SHIPECTRAL_BUILD_PATH}"
    elsif SHIPECTRAL_COMPILER == :gcc
        system "utility/compile_SFML.sh #{SHIPECTRAL_BUILD_PATH}"
    end
end

task :build_anyolite => [:generate_build_dir] do
    if SHIPECTRAL_COMPILER == :msvc
        FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/anyolite")
        unless File.exist?("#{SHIPECTRAL_BUILD_PATH}/anyolite/Rakefile.rb")
            FileUtils.cp_r "third_party/anyolite/.", "#{SHIPECTRAL_BUILD_PATH}/anyolite", :verbose => true
        end
        system "utility/compile_anyolite.bat #{SHIPECTRAL_BUILD_PATH}"
    end
end

task :build_shipectral => [:generate_build_dir, :build_crsfml, :build_sfml, :build_anyolite, :build_shards] do
    FileUtils.mkdir_p("#{SHIPECTRAL_BUILD_PATH}/shipectral")

    if SHIPECTRAL_COMPILER == :msvc
        system "utility/compile_Shipectral.bat #{SHIPECTRAL_BUILD_PATH}"
    elsif SHIPECTRAL_COMPILER == :gcc
        system "utility/compile_Shipectral.sh #{Dir.pwd}/#{SHIPECTRAL_BUILD_PATH}"
    end
end

task :install_shipectral => [:build_shipectral] do
    if SHIPECTRAL_COMPILER == :msvc
        FileUtils.cp_r "#{SHIPECTRAL_BUILD_PATH}/sfml/bin/.", "#{SHIPECTRAL_BUILD_PATH}/shipectral", :verbose => true
    end
end

task :build_shards => [:generate_build_dir, :build_sfml] do
    if SHIPECTRAL_COMPILER == :gcc
        system "SFML_INCLUDE_DIR=#{Dir.pwd}/third_party/sfml/include shards install"
    end
end

task :recompile do
    if SHIPECTRAL_COMPILER == :msvc
        system "utility/compile_Shipectral.bat #{SHIPECTRAL_BUILD_PATH}"
    elsif SHIPECTRAL_COMPILER == :gcc
        system "utility/compile_Shipectral.sh #{Dir.pwd}/#{SHIPECTRAL_BUILD_PATH}"
    end
end

task :test do
    if SHIPECTRAL_COMPILER == :msvc
        system "\"#{SHIPECTRAL_BUILD_PATH}/shipectral/Shipectral.exe\""
    elsif SHIPECTRAL_COMPILER == :gcc
        system "LD_LIBRARY_PATH=\"#{SHIPECTRAL_BUILD_PATH}/sfml/lib\"#{SHIPECTRAL_BUILD_PATH}/shipectral/Shipectral"
    end
end