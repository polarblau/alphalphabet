require 'manifesto'

class Deploy < Thor
  include Thor::Actions
  
  desc "deploy", "Create manifest, ensure coffeescript conversion, export, commit and deploy"
  method_option :message, :type => :string, :aliases => "-m"
  def foobar
    
    say "Exporting"
    run "serve export"
    
    say "Creating manifest"
    Manifesto.cache :directory => './html'
    
    say "Committing everything"
    message = options[:message] || "Deploying."
    run "git add ."
    run "git commit -m #{message}"
    run "git push origin gh-pages"
  end
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
end