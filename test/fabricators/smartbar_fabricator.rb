#Fabricator(:smartbar) do
#  name             "MyString"
#  customer_id      1
#  url              "http://example.com"
#  html             "MyText"
#  minified_html    "MyText"
#  css              "MyText"
#  position_element "MyString"
#  position_prepend false
#  callback_url     "MyString"
#  status           "active"
#end
#
#Fabricator(:cookie_compliance_smartbar, from: :smartbar) do
#  name "Cookie compliance"
#  customer_id 1
#  url "http://example.com"
#  html %Q(<div class="os360-inline-content-wrapper">
#  <div class="os360-inline-content-inner">
#    <div class="os360-inline-content-main">
#      <h2>Cookies on the Demo Site</h2>
#      <p>We use cookies to ensure that we give you the best experience on our website. If you continue without
#        changing your settings, we'll assume that you are happy to receive all cookies on this website.
#        <a href="/demo_app/cookies">Read more</a> about how we use cookies.
#      </p>
#    </div>
#    <div class="os360-inline-content-sidebar">
#      <a href="#" class="btn btn-primary" id="os360-close"><i class="icon icon-ok icon-white"></i><b>Continue</b></a>
#    </div>
#  </div>
#</div>)
#  css %Q(.os360-inline-content-wrapper {
#  background-color: #d4d4d4;
#  margin: 0 auto;
#  padding: 10px 0;
#  width: 100%;
#}
#
#.os360-inline-content-inner {
#  background-color: #fff;
#  border: 1px solid #ccc;
#  border-radius: 5px;
#  color: #222;
#  display: table;
#  margin: 0 10px;
#  padding: 10px;
#}
#
#.os360-inline-content-main {
#  display: table-cell;
#  text-align: left;
#  vertical-align: middle;
#  width: 80%;
#}
#
#.os360-inline-content-main h2 {
#  font-size: 16px;
#  line-height: 22px;
#  margin-top: 0;
#}
#
#.os360-inline-content-main p {
#  font-size: 13px;
#  margin-bottom: 0;
#}
#
#.os360-inline-content-sidebar {
#  display: table-cell;
#  text-align: center;
#  vertical-align: middle;
#  width: 20%;
#}
#
#.os360-inline-content-sidebar .icon {
#  margin-right: 10px;
#})
#  position_element "body"
#  position_prepend true
#  callback_url "http://example.com/callback"
#end
#