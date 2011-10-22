require 'manifesto'

class Utilities < Thor
  include Thor::Actions
  
  desc "deploy", "Create manifest, ensure coffeescript conversion, export, commit and deploy"
  method_option :message, :type => :string, :aliases => "-m"
  def deploy
    
    say "Exporting"
    run "serve export"

    # say "Creating manifest"
    # manifest = Manifesto.cache :directory => html_path
    # File.open("#{html_path}/alphalphabet.manifest", 'w') {|f| 
    #   f.write(manifest.join(""))
    # }
    
    say "Committing everything"
    message = options[:message] || "Deploying."
    run "git add ."
    run "git commit -m \"#{message}\""
    run "git push origin gh-pages"
    
  end
  
  private
  
    def html_path
      File.join(File.dirname(__FILE__), "html")
    end

end