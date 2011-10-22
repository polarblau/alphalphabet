require 'manifesto'

class Utilities < Thor
  include Thor::Actions
  
  HTML_PATH = File.join(File.dirname(__FILE__), "html")
  
  desc "deploy", "Create manifest, ensure coffeescript conversion, export, commit and deploy"
  method_option :message, :type => :string, :aliases => "-m"
  def deploy
    
    say "Exporting"
    run "serve export"
    
    say "Creating manifest"
    manifest = Manifesto.cache :directory => HTML_PATH
    File.open("#{HTML_PATH}/alphalphabet.manifest", 'w') {|f| 
      f.write(manifest.join(""))
    }
    
    say "Committing everything"
    message = options[:message] || "Deploying."
    run "git add ."
    run "git commit -m '#{message}'"
    run "git push origin gh-pages"
  end
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
end