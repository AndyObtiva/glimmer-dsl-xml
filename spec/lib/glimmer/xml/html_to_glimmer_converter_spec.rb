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
      require 'glimmer-dsl-xml'
      
      include Glimmer
      
      html_document = xml {
        html(style: 'max-height: 100%') {
          body(style: "max-height: 100%; font: 'Times New Roman', Arial;") {
            h1(id: 'top-header', class: 'header', 'data-owner': 'John "Bonham" Doe') {
              "Welcome"
            }
            p {
              span {
                "It is good to have "
              }
              strong {
                "you"
              }
              span {
                " in our "
              }
              strong {
                em {
                  "platform"
                }
              }
              span {
                "!"
              }
            }
            form(action: '/owner', method: 'post') {
              input(type: 'text', value: 'you')
            }
          }
        }
      }
      
      puts html_document.to_s
    GLIMMER
    
    expect(glimmer).to eq(expected_glimmer)
  end
end
