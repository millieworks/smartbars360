Fabricator(:smartbar_format_template) do
  name "MyString"
  html "MyString"
  css  "MyString"
end

Fabricator(:inline_format_template, from: :smartbar_format_template) do
  name "Inline"
  html %Q(<div class="os360-inline-content-wrapper">
  <div class="os360-inline-content-inner">
    CONTENT
  </div>
</div>)
  css %Q(.os360-inline-content-wrapper {
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
})
end
