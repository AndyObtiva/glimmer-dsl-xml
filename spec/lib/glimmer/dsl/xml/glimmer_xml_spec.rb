require "spec_helper"
  
describe "Glimmer Xml" do
  include Glimmer
  
  after do
    Glimmer::Config.xml_attribute_underscore = nil # resets it
  end

  it "tests single html tag" do
    @target = html
   
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq("<!DOCTYPE html><html />")
  end
   
  it "tests single document tag upper case" do
    @target = tag(:_name => "DOCUMENT")
    
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq("<DOCUMENT />")
  end
  
  it "tests open and closed html tag" do
    @target = html {}
   
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq("<!DOCTYPE html><html></html>")
  end
   
  it "tests open and closed html tag with contents" do
    @target = html { "This is an HTML Document" }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq("<!DOCTYPE html><html>This is an HTML Document</html>")
  end
  
  it "tests open and closed html tag with attributes" do
    @target = html(:id => "thesis", :class => "document") {
    }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq('<!DOCTYPE html><html id="thesis" class="document"></html>')
  end
  
  it "tests open and closed html tag with attributes and nested body with attributes" do
    @target = html(:id => "thesis", :class => "document") {
      body(:id => "main") {
      }
    }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq('<!DOCTYPE html><html id="thesis" class="document"><body id="main"></body></html>')
  end
  
  it "renders html tag with nested body and video with attributes, including non-value attributes (e.g. loop)" do
    @target = html {
      body {
        video(:loop, :controls, src: "http://videos.org/1.mp4")
      }
    }
  
    expect(@target.to_xml).to eq('<!DOCTYPE html><html><body><video src="http://videos.org/1.mp4" loop controls  /></body></html>')
  end

  it "renders html tag with nested body and video having underscore-containing symbol and string attributes, including non-value attributes (e.g. data_loop)" do
    expect(Glimmer::Config.xml_attribute_underscore).to eq('_')
    @target = html {
      body {
        video(:data_loop, 'data_controls', data_src: "http://videos.org/1.mp4", 'data_dest' => 'www')
      }
    }
    expect(@target.to_xml).to eq('<!DOCTYPE html><html><body><video data_src="http://videos.org/1.mp4" data_dest="www" data_loop data_controls  /></body></html>')
    
    Glimmer::Config.xml_attribute_underscore = '-'
    expect(Glimmer::Config.xml_attribute_underscore).to eq('-')
    @target = html {
      body {
        video(:data_loop, 'data_controls', data_src: "http://videos.org/1.mp4", 'data_dest' => 'www')
      }
    }
    expect(@target.to_xml).to eq('<!DOCTYPE html><html><body><video data-src="http://videos.org/1.mp4" data_dest="www" data-loop data_controls  /></body></html>')
  end

  it "renders html tag with nested head and link" do
    @target = html {
      head {
        link rel: 'stylesheet', href: 'styles.css'
      }
    }
  
    expect(@target.to_xml).to eq('<!DOCTYPE html><html><head><link rel="stylesheet" href="styles.css"  /></head></html>')
  end

  it "renders html fragment (not a full document with body/head ) with nested video tag having attributes, including non-value attributes (e.g. loop)" do
    @target = html {
      video(:loop, :controls, src: "http://videos.org/1.mp4")
    }
  
    expect(@target.to_xml).to eq('<video src="http://videos.org/1.mp4" loop controls  />')
  end

  it "renders xml tag with multiple nested children" do
    @target = xml {
      span {'Hello'}
      br
    }
  
    expect(@target.to_xml).to eq('<span>Hello</span><br />')
  end

  it "renders xml tag with nested video with attributes, including non-value attributes (e.g. loop)" do
    @target = xml {
      video(:loop, :controls, src: "http://videos.org/1.mp4") {
        source(src: 'video1.mp4', type: 'video/mp4')
        source(src: 'video1.ogg', type: 'video/ogg')
      }
    }
  
    expect(@target.to_xml).to eq('<video src="http://videos.org/1.mp4" loop controls><source src="video1.mp4" type="video/mp4"  /><source src="video1.ogg" type="video/ogg"  /></video>')
  end

  it 'renders meta tag' do
    @target = html {
      head {
        meta(name: "viewport", content: "width=device-width, initial-scale=2.0")
      }
    }
  
    expect(@target.to_xml).to eq('<!DOCTYPE html><html><head><meta name="viewport" content="width=device-width, initial-scale=2.0"  /></head></html>')
  end
  
  it "tests tag with contents before and after nested tag" do
    @target = html(:id => "thesis", :class => "document") {
      text "Before body"
      body(:id => "main") {
      }
      text "When a string is the last part of the tag contents, text prefix is optional"
    }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq('<!DOCTYPE html><html id="thesis" class="document">Before body<body id="main"></body>When a string is the last part of the tag contents, text prefix is optional</html>')
  end
  
  it "tests different name spaced tags" do
    @target = html(:id => "thesis", :class => "document") {
      document.body(:id => "main") {
      }
    }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq('<!DOCTYPE html><html id="thesis" class="document"><document:body id="main"></document:body></html>')
  end
  
  it "tests different name spaced attributes and tags" do
    @target = html(:id => "thesis", :class => "document") {
      document.body(document.id => "main") {
      }
    }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq('<!DOCTYPE html><html id="thesis" class="document"><document:body document:id="main"></document:body></html>')
  end
  
  it "tests name space context" do
    @target = name_space(:acme) {
      product(:id => "thesis", :class => "document") {
        component(:id => "main") {
        }
      }
    }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq('<acme:product id="thesis" class="document"><acme:component id="main"></acme:component></acme:product>')
  end
  
  it "tests name space context wrapping html" do
    @target = name_space(:w3c) {
      html(:id => "thesis", :class => "document") {
        body(:id => "main") {
        }
      }
    }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq('<w3c:html id="thesis" class="document"><w3c:body id="main"></w3c:body></w3c:html>')
  end
  
  it "tests two name space contexts" do
    @target = name_space(:w3c) {
      document(:id => "thesis", :class => "document") {
        name_space(:document) {
          sectionDivider(:id => "main") {
          }
        }
      }
    }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq('<w3c:document id="thesis" class="document"><document:sectionDivider id="main"></document:sectionDivider></w3c:document>')
  end
  
  it "tests two name space contexts including contents" do
    @target = name_space(:w3c) {
      document(:id => "thesis", :class => "document") {
        text "before section divider"
        name_space(:document) {
          sectionDivider(:id => "main") {
            "section divider"
          }
        }
        text "after section divider"
      }
    }
  
    expect(@target).to_not be_nil
    expect(@target.to_xml).to eq('<w3c:document id="thesis" class="document">before section divider<document:sectionDivider id="main">section divider</document:sectionDivider>after section divider</w3c:document>')
  end
  
  it "tests mixed contents custom syntax" do
    @target = html{"before section divider#strong{section divider}after section divider"}
  
    expect(@target).to_not be_nil
    expect(@target.to_html).to eq('before section divider<strong>section divider</strong>after section divider')
  end
  

end
