require "spec_helper"

describe Glimmer::XML::HTMLToGlimmerConverter do
  it "converts HTML to Glimmer syntax" do
    html = <<~HTML
      <html style='max-height: 100%'>
        <body style="max-height: 100%; font: 'Times New Roman', Arial;">
          <h1 id="top-header" class="header" data-owner='John "Bonham" Doe'>Welcome</h1>
          <p>It is good to have <strong>you</strong> in our <strong><em>platform</em></strong>!</p>
          <form action="/owner" method="post">
            <input type="text" value="you" />
          </form>
        </body>
      </html>
    HTML
   
    glimmer = subject.convert(html)
    
    expected_glimmer = <<~GLIMMER

    GLIMMER
    
    expect(glimmer).to eq(expected_glimmer)
  end
end
