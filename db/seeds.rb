Customer.create(name: "Demo Application")
@admin = Role.create(name: "Admin")
Role.create(name: "CustomerUser")
User.create([ { email: "tim@onegiantleap.se", password: "121212", password_confirmation: "121212", role_ids: [@admin.id] },
              { email: "niklas@onserver.se", password: "123456", password_confirmation: "123456", role_ids: [@admin.id] } ])

RuleType.create([ { name: "First page view", indicator: "PageImpressions", default_value: 1, value_operator: "==" },
                  { name: "Xth page view", indicator: "PageImpressions", value_label: "Number of page views", default_value: 1, value_operator: "==" },
                  { name: "More than X page views", indicator: "PageImpressions", value_label: "Number of page views", default_value: 5, value_operator: ">" },
                  { name: "Fewer than X page views", indicator: "PageImpressions", value_label: "Number of page views", default_value: 10, value_operator: "<" },
                  { name: "Every Nth page view", indicator: "PageImpressions", value_label: "Number of page views", default_value: 1, value_operator: "%" },

                  { name: "First visit", indicator: "Visits", default_value: 1, value_operator: "==" },
                  { name: "Xth visit", indicator: "Visits", value_label: "Number of visits", default_value: 1, value_operator: "==" },
                  { name: "More than X visits", indicator: "Visits", value_label: "Number of visits", default_value: 1, value_operator: ">" },
                  { name: "Fewer than X visits", indicator: "Visits", value_label: "Number of visits", default_value: 5, value_operator: "<" },
                  { name: "Every Nth visit", indicator: "Visits", value_label: "Number of visits", default_value: 1, value_operator: "%" },

                  { name: "Days since last visit", indicator: "TrackedUserUpdatedAt", value_label: "Number of days", default_value: 1, value_operator: ">=" },
                  { name: "Page view duration", indicator: "JavascriptPageLoad", value_label: "Number of minutes", default_value: 1, value_operator: "setTimeout" },
                  { name: "Visit duration", indicator: "JavascriptSessionStart", value_label: "Number of minutes", default_value: 1, value_operator: "setTimeout" } ])

SmartbarFormatTemplate.create([
{ name: "Inline",
  html: %Q(<div class="os360-inline-content-wrapper">
  <div class="os360-inline-content-inner">
    CONTENT
  </div>
</div>),
  css: %Q(.os360-inline-content-wrapper {
  background-color: #d4d4d4;
  margin: 0 auto;
  padding: 10px 0;
  width: 100%;
}

.os360-inline-content-inner {
  background-color: #fff;
  border: 1px solid #ccc;
  border-radius: 5px;
  color: #222;
  display: table;
  margin: 0 10px;
  padding: 10px;
}) },
{ name: "Pull up",
  html: %Q(<div class="os360-slider os360-slider-bottom">
    <div class="os360-closed">
        <div class="os360-tab">
            <a href="#" id="os360-show-content">Open <i class="os360-icon-plus-white"></i></a>
        </div>
    </div>
    <div class="os360-open">
        <div class="os360-tab">
            <a href="#" id="os360-hide-content">Close <i class="os360-icon-minus-white"></i></a>
        </div>
        <div class="os360-content">
            CONTENT
        </div>
    </div>
</div>),
  css: %Q(#os360-widget {
    bottom: 0;
    position: fixed;
    right: 50px;
}

.os360-slider {
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 14px;
}

.os360-open,
.os360-closed {
    overflow: hidden;
}

.os360-tab a {
    background-color: #363636;
    border-color: rgba(0, 0, 0, 0.15) rgba(0, 0, 0, 0.15) #363636;
    border-style: solid;
    border-width: 1px;

    -webkit-border-top-left-radius: 5px;
    -webkit-border-top-right-radius: 5px;
    -moz-border-radius-topleft: 5px;
    -moz-border-radius-topright: 5px;
    border-top-left-radius: 5px;
    border-top-right-radius: 5px;
    color: #fff;
    cursor: pointer;
    float: right;
    display: block;
    left: 0;
    padding: 4px 0;
    position: relative;
    text-align: center;
    text-decoration: none;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
    top: 1px;
    width: 80px;
}

.os360-tab a:hover {
    background-color: #363636;
    color: #fff;
    text-decoration: none;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
}

.os360-icon-plus-white {
    background: url(http://smartbars.onserver360.se/assets/plus.png) top left no-repeat;
    display: inline-block;
    height: 14px;
    margin-right: 6px;
    margin-top: 1px;
    verical-align: text-top;
    width: 14px;
}

.os360-icon-minus-white {
    background: url(http://smartbars.onserver360.se/assets/minus.png) top left no-repeat;
    display: inline-block;
    height: 14px;
    margin-right: 6px;
    margin-top: 1px;
    verical-align: text-top;
    width: 14px;
}

.os360-content {
    background-color: #363636;
    border-color: rgba(0, 0, 0, 0.15) rgba(0, 0, 0, 0.15) rgba(0, 0, 0, 0.25);
    border-style: solid;
    border-width: 1px 1px 0;
    clear: both;
    color: #fff;

    -webkit-border-top-left-radius: 5px;
    -moz-border-radius-topleft: 5px;
    border-top-left-radius: 5px;

    padding: 10px 10px 15px;
}) },
{ name: "Pull down",
  html: %Q(<div class="os360-slider os360-slider-top">
    <div class="os360-closed">
        <div class="os360-tab">
            <a href="#" id="os360-show-content">Open <i class="os360-icon-plus-white"></i></a>
        </div>
    </div>
    <div class="os360-open">
        <div class="os360-content">
            CONTENT
        </div>
        <div class="os360-tab">
            <a href="#" id="os360-hide-content">Close <i class="os360-icon-minus-white"></i></a>
        </div>
    </div>
</div>),
  css: %Q(#os360-widget {
    position: fixed;
    right: 50px;
    top: 0;
}

.os360-slider {
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 14px;
}

.os360-open,
.os360-closed {
    overflow: hidden;
}

.os360-tab a {
    background-color: #363636;
    border-color: transparent rgba(0, 0, 0, 0.15) rgba(0, 0, 0, 0.15);
    border-style: solid;
    border-width: 1px;

    -webkit-border-bottom-left-radius: 5px;
    -webkit-border-bottom-right-radius: 5px;
    -moz-border-radius-bottomleft: 5px;
    -moz-border-radius-bottomright: 5px;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
    color: #fff;
    cursor: pointer;
    display: block;
    float: right;
    left: 0;
    padding: 4px 0;
    position: relative;
    text-align: center;
    text-decoration: none;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
    top: -1px;
    width: 80px;
}

.os360-tab a:hover {
    background-color: #363636;
    color: #fff;
    text-decoration: none;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
}

.os360-icon-plus-white {
    background: url(http://smartbars.onserver360.se/assets/plus.png) top left no-repeat;
    display: inline-block;
    height: 14px;
    margin-right: 6px;
    margin-top: 1px;
    verical-align: text-top;
    width: 14px;
}

.os360-icon-minus-white {
    background: url(http://smartbars.onserver360.se/assets/minus.png) top left no-repeat;
    display: inline-block;
    height: 14px;
    margin-right: 6px;
    margin-top: 1px;
    verical-align: text-top;
    width: 14px;
}

.os360-content {
    background-color: #363636;
    border-color: rgba(0, 0, 0, 0.15) rgba(0, 0, 0, 0.15) rgba(0, 0, 0, 0.25);
    border-style: solid;
    border-width: 1px 1px 0;
    color: #fff;

    -webkit-border-bottom-left-radius: 5px;
    -moz-border-radius-bottomleft: 5px;
    border-bottom-left-radius: 5px;

    padding: 10px 10px 15px;
}) } ])

SmartbarContentTemplate.create([
{ name: "Cookie compliance",
  html: %Q(<div class="os360-inline-content-main">
  <h2>Cookies on the Demo Site</h2>
  <p>We use cookies to ensure that we give you the best experience on our website. If you continue without
     changing your settings, we'll assume that you are happy to receive all cookies on this website.
     <a href="COOKIE_PAGE_URL">Read more</a> about how we use cookies.
  </p>
</div>
<div class="os360-inline-content-sidebar">
  <a href="#" class="os360-btn" id="os360-close"><i class="os360-icon-ok-white"></i><b>Continue</b></a>
</div>),
  css: %Q(.os360-inline-content-main {
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
    background: url(http://smartbars.onserver360.se/assets/tick.png) top left no-repeat;
    display: inline-block;
    height: 14px;
    margin-right: 6px;
    margin-top: 1px;
    vertical-align: text-top;
    width: 14px;
})},
{ name: "Email newsletter",
  html: %Q(<div class="os360-user-input">
    <p class="os360-rubric">Enter your email address to receive our newsletter</p>
    <form id="os360-form" class="os360-form-inline">
        <div class="os360-input-append">
            <input type="text" name="email" placeholder="Email" class="os360-input-large" required="required">
            <button type="submit" class="os360-btn">Subscribe</button>
        </div>
    </form>
</div>
<div class="os360-confirmation">
    <p>Thank you. Your request is being processed.</p>
</div>),
  css: %Q(.os360-content .os360-rubric {
    margin-bottom: 5px;
}

.os360-content form {
    margin-bottom: 0;
}

#os360-form input {
    background-color: #fff;
    border: 1px solid #ccc;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
    display: inline-block;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 14px;
    font-weight: normal;
    height: 20px;
    line-height: 20px;
    margin: 0;
    padding: 4px 6px;
    transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
    vertical-align: middle;
}

#os360-form  input:-moz-placeholder {
    color: #999;
}

.os360-input-large {
    width: 210px
}

.os360-input-append {
    display: inline-block;
    font-size: 0;
    line-height: 20px;
    margin-bottom: 0;
    vertical-align: middle;
    white-space: nowrap;
}

.os360-input-append input {
    border-radius: 3px 0 0 3px;
    position: relative;
}

.os360-btn::-moz-focus-inner,
#os360-form input::-moz-focus-inner {
    border: 0 none;
    padding: 0;
}

#os360-form input:focus:required:invalid {
    border-color: #ee5f5b;
    color: #b94a48;
}

#os360-form input:focus:required:invalid:focus {
    border-color: #e9322d;
    box-shadow: 0 0 6px #f8b9b7;
}

.os360-btn {
    border-color: rgba(0, 0, 0, 0.25) rgba(0, 0, 0, 0.15) rgba(0, 0, 0, 0.15);
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background-color: whitesmoke;
    background-image: -webkit-linear-gradient(top, #fff, #e6e6e6);
    background-image: linear-gradient(to bottom, white, #e6e6e6);
    background-repeat: repeat-x;
    border-image: none;
    border-radius: 4px 4px 4px 4px;
    border-style: solid;
    border-width: 1px;
    box-shadow: 0 1px 0 rgba(255, 255, 255, 0.2) inset, 0 1px 2px rgba(0, 0, 0, 0.05);
    color: #333;
    cursor: pointer;
    display: inline-block;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 14px;
    font-weight: normal;
    line-height: 20px;
    margin: 0;
    padding: 4px 10px;
    text-align: center;
    text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75);
    vertical-align: middle;
}

.os360-input-append .os360-btn {
    margin-left: -1px;
    vertical-align: top;
}

.os360-input-append .os360-btn:last-child {
    border-radius: 0 3px 3px 0;
}) },
{ name: "File download",
  html: %Q(<div class="os360-user-input">
    <p class="os360-rubric">Enter your Name and email address to see the download link</p>
    <form id="os360-form" class="os360-form-horizontal">
        <div class="os360-control-group">
            <label class="os360-control-label" for="os360-name">Name</label>
            <div class="os360-controls">
                <input type="text" name="name" id="os360-name" class="os360-input-large" required="required">
            </div>
        </div>
        <div class="os360-control-group">
            <label class="os360-control-label" for="os360-email">Email</label>
            <div class="os360-controls">
                <input type="text" name="email" id="os360-email" class="os360-input-large" required="required">
            </div>
        </div>
        <div class="os360-control-group">
            <div class="os360-controls">
                <button type="submit" class="os360-btn">Subscribe</button>
            </div>
        </div>
    </form>
</div>
<div class="os360-confirmation">
    <p>Thank you. The file can be downloaded from <a href="DOWNLOAD_URL">here</a>.</p>
</div>),
  css: %Q(.os360-content .os360-rubric {
    margin-bottom: 5px;
}

.os360-content a {
    color: #42C0FB;
    text-decoration: none;
}

.os360-content a:hover {
    text-decoration: underline;
}

.os360-content form {
    margin-bottom: 0;
}

#os360-form input {
    background-color: #fff;
    border: 1px solid #ccc;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
    display: inline-block;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 14px;
    font-weight: normal;
    height: 20px;
    line-height: 20px;
    margin: 0;
    padding: 4px 6px;
    transition: border 0.2s linear 0s, box-shadow 0.2s linear 0s;
    vertical-align: middle;
}

#os360-form input:-moz-placeholder {
    color: #999;
}

.os360-input-large {
    width: 210px
}

.os360-btn::-moz-focus-inner,
#os360-form input::-moz-focus-inner {
    border: 0 none;
    padding: 0;
}

#os360-form input:focus:required:invalid {
    border-color: #ee5f5b;
    color: #b94a48;
}

#os360-form input:focus:required:invalid:focus {
    border-color: #e9322d;
    box-shadow: 0 0 6px #f8b9b7;
}

.os360-form-horizontal .os360-control-group {
    margin-bottom: 10px;
}

.os360-form-horizontal .os360-control-label {
    float: left;
    padding-top: 5px;
    text-align: right;
    width: 80px;
}

.os360-form-horizontal .os360-controls {
    margin-left: 90px;
}

.os360-btn {
    border-color: rgba(0, 0, 0, 0.15) rgba(0, 0, 0, 0.15) rgba(0, 0, 0, 0.25);
    -moz-border-bottom-colors: none;
    -moz-border-left-colors: none;
    -moz-border-right-colors: none;
    -moz-border-top-colors: none;
    background-color: whitesmoke;
    background-image: -webkit-linear-gradient(top, #fff, #e6e6e6);
    background-image: linear-gradient(to bottom, white, #e6e6e6);
    background-repeat: repeat-x;
    border-image: none;
    border-radius: 4px 4px 4px 4px;
    border-style: solid;
    border-width: 1px;
    box-shadow: 0 1px 0 rgba(255, 255, 255, 0.2) inset, 0 1px 2px rgba(0, 0, 0, 0.05);
    color: #333;
    cursor: pointer;
    display: inline-block;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 14px;
    font-weight: normal;
    line-height: 20px;
    margin: 0;
    padding: 4px 10px;
    text-align: center;
    text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75);
    vertical-align: middle;
})} ])