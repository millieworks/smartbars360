Fabricator(:smartbar_content_template) do
  name "MyString"
  html "MyString"
  css  "MyString"
end

Fabricator(:cookie_compliance_content_template, from: :smartbar_content_template) do
  name "Cookie compliance"
  html %Q(<div class="os360-inline-content-main">
  <h2>Cookies on the Demo Site</h2>
  <p>We use cookies to ensure that we give you the best experience on our website. If you continue without
     changing your settings, we'll assume that you are happy to receive all cookies on this website.
     <a href="COOKIE_PAGE_URL">Read more</a> about how we use cookies.
  </p>
</div>
<div class="os360-inline-content-sidebar">
  <a href="#" class="os360-btn" id="os360-close"><i class="os360-icon-ok-white"></i><b>Continue</b></a>
</div>)
  css  %Q(.os360-inline-content-main {
    display: table-cell;
    text-align: left;
    vertical-align: middle;
    width: 80%;
}

.os360-inline-content-main h2 {
    font-size: 16px;
    font-weight: bold;
    line-height: 22px;
    margin-top: 0;
    text-rendering: optimizelegibility;
}

.os360-inline-content-main p {
    font-size: 13px;
    margin-bottom: 0;
}

.os360-inline-content-main a {
    color: #08c;
    text-decoration: none;
}

.os360-inline-content-main a:hover {
    text-decoration: underline;
}

.os360-inline-content-sidebar {
    display: table-cell;
    text-align: center;
    vertical-align: middle;
    width: 20%;
}

.os360-btn {
    background-color: #06c;
    background-image: linear-gradient(to bottom, #08c, #04c);
    background-repeat: repeat-x;
    border-color: #04c #04c #002a80;
    border-image: none;
    border-radius: 4px 4px 4px 4px;
    border-style: solid;
    border-width: 1px;
    color: #fff;
    cursor: pointer;
    display: inline-block;
    margin-bottom: 0;
    padding: 4px 10px;
    text-align: center;
    text-decoration: none;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
    vertical-align: middle;
}

.os360-icon-ok-white {
    background: url("/assets/tick.png") top left no-repeat;
    display: inline-block;
    height: 14px;
    margin-right: 6px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
})
end
