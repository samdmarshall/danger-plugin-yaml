module Danger
  class DangerYAML < Plugin
    # check to see if yamllint is installed
    # @return [Bool]
    def yamllint_installed?
      `which yamllint`.strip.empty? == false
    end

    # lint paths
    # @param path_pattern default path pattern is "*/**/*.yml", pass "nil" to use the files in the commit
    # @return [void]
    def lint_yaml_files(path_pattern = "*/**/*.yml")
      system 'pip install --user yamllint' unless yamllint_installed?

      raise "yamllint is not in the user's PATH, or it failed to install" unless yamllint_installed?

      found_files = get_files(path_pattern)

      current_slug = env.ci_source.repo_slug

      lint_results = Hash[found_files.uniq.collect { |yaml| [yaml, run_yamllint(yaml)] }]
      
      if lint_results.count > 0
        message = "### yamllint found issues\n\n"
        lint_results.each do |path, yaml|
          github_loc = "/#{current_slug}/tree/#{github.branch_for_head}/#{path}"
          message << "#### [#{path}](#{github_loc})\n\n"
        
          message << "Line | Severity | Message |\n"
          message << "| --- | ----- | ----- |\n"

          yaml.each do |result|
            message << "#{result[1]} | #{result[3]} | #{result[4]}\n"
          end

          message << "\n\n"       
        end

        markdown(message)
      end
    end

    def run_yamllint(file)
      output = `yamllint --format parsable #{file}`.strip
      return output.scan(/(.+):(\d+):(\d+): \[(.+)\] (.+)/)
    end

    def get_files(files)
      # Either use files provided, or use the modified + added
      yaml_files = files ? Dir.glob(files) : (git.modified_files + git.added_files)
      yaml_files.select { |line| line.end_with? '.yaml', '.yml' }
    end
  end
end
